local M = {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
}

function M.config()
  local gf = require "grug-far"
  gf.setup {
    windowCreationCommand = 'tab split',
  }
  local wk = require "which-key"
  wk.add {
    { "<leader>fg", "<cmd>GrugFar<cr>", desc = "Replace", icon = "" },
  }
end

return M
