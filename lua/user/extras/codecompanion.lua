local M = {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

function M.config()
  require("codecompanion").setup {
    display = {
      action_palette = {
        provider = "snacks",
      },
    },
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
      cmd = {
        adapter = "copilot",
      },
    },
  }
  vim.cmd [[cab cc CodeCompanion]]
  local wk = require "which-key"
  wk.add {
    { "<leader>C", group = "Code Companion", mode = { "n", "v" } },
    { "<leader>Ca", "<cmd>CodeCompanionAction<cr>", desc = "Action", mode = { "n", "v" } },
    { "<leader>CA", "<cmd>CodeCompanionChat Add<cr>", desc = "Add Selection", mode = { "n", "v" } },
    { "<leader>Cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Chat", mode = { "n", "v" } },
  }
end

return M
