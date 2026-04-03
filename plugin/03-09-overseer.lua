vim.schedule(function()
  vim.pack.add({
    {src="https://github.com/stevearc/overseer.nvim"}
  })

  require("overseer").setup {}

  local wk = require "which-key"
  wk.add {
    { "<leader>T", group = "Tasks" },
    { "<leader>Tt", "<cmd>OverseerToggle<CR>", desc = "Toggle" },
    { "<leader>Tr", "<cmd>OverseerRun<CR>", desc = "Run" },
  }
end)
