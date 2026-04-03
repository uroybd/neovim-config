-- Setup lazy loading
local function load_codediff()
  vim.pack.add({
    {src="https://github.com/esmuellert/codediff.nvim"}
  })
  
  require("codediff").setup({
    diff = {
      conflict_result_position = "center",
    }
  })
end

-- Setup keymaps
local wk = require "which-key"
wk.add {
  { "<leader>gd", group = "Diff" },
  { 
    "<leader>gdc", 
    function()
      load_codediff()
      vim.cmd("CodeDiff main HEAD")
    end, 
    desc = "Compare HEAD with main" 
  },
  { 
    "<leader>gdo", 
    function()
      load_codediff()
      vim.cmd("CodeDiff main")
    end, 
    desc = "Compare with main" 
  },
}

-- Create command
vim.api.nvim_create_user_command("CodeDiff", function(opts)
  load_codediff()
  vim.cmd("CodeDiff " .. opts.args)
end, { nargs = "*" })
