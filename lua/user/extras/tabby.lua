local M = {
  "nanozuki/tabby.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  require("tabby").setup {}
  local wk = require "which-key"
  wk.add {
    { "<leader>aj", "<cmd>Tabby jump_to_tab<cr>", desc = "Jump to tab" },
  }
end

return M
