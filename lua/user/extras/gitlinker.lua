local M = {
  "linrongbin16/gitlinker.nvim",
  event = { "VeryLazy" },
  version = "4*",
}

function M.config()
  require("gitlinker").setup {}

  local wk = require "which-key"
  wk.add {
    { "<leader>gl", "<cmd>GitLink<cr>", desc = "Copy Git URL", icon = " ", mode = { "n", "v" } },
  }
end

return M
