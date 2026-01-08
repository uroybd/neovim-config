local M = {
  "esmuellert/codediff.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "CodeDiff",
}

function M.config()
  require("codediff").setup({})
end

local wk = require "which-key"
wk.add {
  { "<leader>gd", group = "Diff" },
  { "<leader>gdc", "<cmd>CodeDiff main HEAD<cr>", desc = "Compare HEAD with main" },
  { "<leader>gdo", "<cmd>CodeDiff main<cr>", desc = "Compare with main" },
}

return M
