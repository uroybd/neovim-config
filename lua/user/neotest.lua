local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "fredrikaverpil/neotest-golang", version = "*" },
  },
}

function M.config()
  require("neotest").setup {
    adapters = {
      require "neotest-golang" {}, -- Registration
    },
  }
end

return M
