local test_config = require("overseer.template.test_config")

return {
  name = "TestFile",
  builder = function()
    local filetype = vim.bo.filetype
    local spec = test_config.specs[filetype]
    
    if not spec then
      vim.notify("TestFile: Unsupported file type: " .. filetype, vim.log.levels.WARN)
      return nil
    end
    
    local test_names = test_config.find_all_tests(filetype)
    
    if #test_names == 0 then
      vim.notify("TestFile: No tests found in file", vim.log.levels.WARN)
      return nil
    end
    
    local filename = vim.fn.expand("%:p")
    local task = spec.build_file(test_names, filename)
    
    task.cwd = vim.fn.getcwd()
    task.components = { "default" }
    
    return task
  end,
  condition = {
    filetype = test_config.get_supported_filetypes(),
  },
}
