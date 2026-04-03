-- Setup lazy loading
local function load_grug_far()
  vim.pack.add({
    {src="https://github.com/MagicDuck/grug-far.nvim"}
  })
  
  require("grug-far").setup {
    windowCreationCommand = 'tab split',
  }
end

-- Setup keymaps
local wk = require "which-key"
wk.add {
  { 
    "<leader>fg", 
    function()
      load_grug_far()
      vim.cmd("GrugFar")
    end, 
    desc = "Replace", 
    icon = "" 
  },
}

-- Create command
vim.api.nvim_create_user_command("GrugFar", function(opts)
  load_grug_far()
  vim.cmd("GrugFar " .. (opts.args or ""))
end, { nargs = "*" })
