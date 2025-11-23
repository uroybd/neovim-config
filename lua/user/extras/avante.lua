local M = {
  "yetone/avante.nvim",
  build = "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

function M.config()
  require("avante").setup {
    provider = "copilot", -- or "snacks" or "none"
    -- providers = {
    --   copilot = {
    --     model = "claude-3.7-sonnet",
    --   },
    -- },
  }
  local wk = require "which-key"
  wk.add {
    { "<leader>A", group = "Avante" },
    { "<leader>Aa", "<cmd>AvanteAsk<cr>", desc = "Ask Avante" },
    { "<leader>At", "<cmd>AvanteToggle<cr>", desc = "Toggle Avante" },
    { "<leader>Ac", "<cmd>AvanteChat<cr>", desc = "Chat with Avante" },
    { "<leader>Ah", "<cmd>AvanteHistory<cr>", desc = "Avante History" },
    { "<leader>Af", "<cmd>AvanteFocus<cr>", desc = "(De)Focus Avante" },
    { "<leader>Ac", "<cmd>AvanteStop<cr>", desc = "Stop Avante" },
    { "<leader>Ar", "<cmd>AvanteReset<cr>", desc = "Refresh Avante" },
    { "<leader>As", "<cmd>AvanteSwitchSelectorProvider<cr>", desc = "Avante: Switch Selector Provider" },
    { "<leader>Am", "<cmd>AvanteModels<cr>", desc = "Show Avante Models" },
  }
end

return M
