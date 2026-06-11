-- Shared test runner configuration for different file types
local M = {}

-- Language-specific test configurations
M.specs = {
  go = {
    -- TreeSitter query to find test functions
    query = [[
      (
        function_declaration name: (identifier) @test-name
        (#match? @test-name "^(Test|Benchmark|Fuzz)")
      )
    ]],
    
    -- Build command for running nearest test
    build_nearest = function(test_name, filename)
      return {
        cmd = { "go" },
        args = { "test", "-v", "-run", "^" .. test_name .. "$" },
      }
    end,
    
    -- Build command for running all tests in file
    build_file = function(test_names, filename)
      local path = vim.fn.fnamemodify(filename, ":.:h")
      local args = { "test", "-v" }
      
      if path ~= "." then
        table.insert(args, string.format("./%s/...", path))
      else
        table.insert(args, "./...")
      end
      
      -- Run only tests from this file by matching all test names
      table.insert(args, "-run")
      table.insert(args, "^(" .. table.concat(test_names, "|") .. ")$")
      
      return {
        cmd = { "go" },
        args = args,
      }
    end,
    
    -- Extract test name from TreeSitter node
    extract_test_name = function(node)
      -- For Go, the node is already the identifier, parent is function_declaration
      local parent = node:parent()
      if parent and parent:type() == "function_declaration" then
        return vim.treesitter.get_node_text(node, 0)
      end
      return nil
    end,
  },
  
  rust = {
    -- TreeSitter query to find test functions
    query = [[
      (
        mod_item name: (identifier) @test-name
        (#match? @test-name "[Tt]est")
      )
      
      (
        function_item name: (identifier) @test-name
        (#match? @test-name "[Tt]est")
      )
    ]],
    
    -- Build command for running nearest test
    build_nearest = function(test_name, filename)
      return {
        cmd = { "cargo" },
        args = { "test", "--lib", test_name, "--", "--exact" },
      }
    end,
    
    -- Build command for running all tests in file
    build_file = function(test_names, filename)
      -- Build module path from file system structure
      local file_parts = vim.fn.split(vim.fn.fnamemodify(filename, ":.:r"), "/")
      
      -- Remove src prefix
      if file_parts[1] == "src" then
        table.remove(file_parts, 1)
      end
      
      local path_parts = {}
      -- Process file parts: lib/main/mod become their parent's name
      for _, part in ipairs(file_parts) do
        if part ~= "lib" and part ~= "main" and part ~= "mod" then
          table.insert(path_parts, part)
        end
      end
      
      local args = { "test", "--lib" }
      if #path_parts > 0 then
        table.insert(args, table.concat(path_parts, "::") .. "::")
      end
      
      return {
        cmd = { "cargo" },
        args = args,
      }
    end,
    
    -- Extract full module path for test from TreeSitter node
    extract_test_name = function(node)
      local parent = node:parent()
      
      -- Only handle function_item nodes (actual test functions, not modules)
      if not parent or parent:type() ~= "function_item" then
        return nil
      end
      
      local path_parts = {}
      
      -- Build module path from file system structure
      local filename = vim.fn.expand("%:p")
      local file_parts = vim.fn.split(vim.fn.fnamemodify(filename, ":.:r"), "/")
      
      -- Remove src prefix
      if file_parts[1] == "src" then
        table.remove(file_parts, 1)
      end
      
      -- Process file parts: lib/main/mod become their parent's name
      for _, part in ipairs(file_parts) do
        if part ~= "lib" and part ~= "main" and part ~= "mod" then
          table.insert(path_parts, part)
        end
      end
      
      -- Get the test function name
      local test_func_name = vim.treesitter.get_node_text(node, 0)
      
      -- Walk up to find parent modules IN THIS FILE
      local current = parent:parent()
      while current do
        if current:type() == "mod_item" then
          for child in current:iter_children() do
            if child:type() == "identifier" then
              local mod_name = vim.treesitter.get_node_text(child, 0)
              table.insert(path_parts, mod_name)
              break
            end
          end
        end
        current = current:parent()
      end
      
      -- Add the test function name at the end
      table.insert(path_parts, test_func_name)
      return table.concat(path_parts, "::")
    end,
  },
}

-- Get supported filetypes
function M.get_supported_filetypes()
  local types = {}
  for ft, _ in pairs(M.specs) do
    table.insert(types, ft)
  end
  return types
end

-- Find nearest test at cursor position
function M.find_nearest_test(filetype)
  local spec = M.specs[filetype]
  if not spec then
    return nil
  end
  
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1] - 1
  
  local parser = vim.treesitter.get_parser(0, filetype)
  if not parser then
    return nil
  end
  
  local query = vim.treesitter.query.parse(filetype, spec.query)
  local tree = parser:parse()[1]
  local root = tree:root()
  
  local test_name = nil
  local closest_line = -1
  
  for id, node in query:iter_captures(root, 0, 0, -1) do
    local name = query.captures[id]
    if name == "test-name" then
      local start_row = node:range()
      if start_row <= line and start_row > closest_line then
        closest_line = start_row
        local extracted = spec.extract_test_name(node)
        if extracted then
          test_name = extracted
        end
      end
    end
  end
  
  return test_name
end

-- Find all tests in current file
function M.find_all_tests(filetype)
  local spec = M.specs[filetype]
  if not spec then
    return {}
  end
  
  local parser = vim.treesitter.get_parser(0, filetype)
  if not parser then
    return {}
  end
  
  local query = vim.treesitter.query.parse(filetype, spec.query)
  local tree = parser:parse()[1]
  local root = tree:root()
  
  local test_names = {}
  
  for id, node in query:iter_captures(root, 0, 0, -1) do
    local name = query.captures[id]
    if name == "test-name" then
      local extracted = spec.extract_test_name(node)
      if extracted then
        table.insert(test_names, extracted)
      end
    end
  end
  
  return test_names
end

return M
