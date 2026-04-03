-- Setup keymaps to trigger loading
local function load_trouble()
  vim.pack.add({
    {src="https://github.com/folke/trouble.nvim"}
  })
  require("trouble").setup {}
end

local wk = require "which-key"
wk.add {
  {
    "<leader>dw",
    function()
      load_trouble()
      vim.cmd("Trouble diagnostics toggle focus=true")
    end,
    desc = "Workspace Diagnostics",
  },
  {
    "<leader>dd",
    function()
      load_trouble()
      vim.cmd("Trouble diagnostics toggle filter.buf=0 focus=true")
    end,
    desc = "Buffer Diagnostics",
  },
  {
    "<leader>lo",
    function()
      load_trouble()
      vim.cmd("Trouble symbols toggle focus=false")
    end,
    desc = "Outline",
  },
  {
    "<leader>xL",
    function()
      load_trouble()
      vim.cmd("Trouble loclist toggle")
    end,
    desc = "Location List (Trouble)",
  },
  {
    "<leader>xQ",
    function()
      load_trouble()
      vim.cmd("Trouble qflist toggle")
    end,
    desc = "Quickfix List (Trouble)",
  },
}

-- Create command to load trouble
vim.api.nvim_create_user_command("Trouble", function(opts)
  load_trouble()
  vim.cmd("Trouble " .. opts.args)
end, { nargs = "*" })
