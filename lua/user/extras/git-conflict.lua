local M = {
  "akinsho/git-conflict.nvim",
  event = "VeryLazy",
}

M.config = function()
  local wk = require "which-key"
  wk.add {
    { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Conflict: Choose Both", icon = "󰜛" },
    { "<leader>gcl", "<cmd>GitConflictListQf<cr>", desc = "Conflict: List", icon = "󱖫" },
    { "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", desc = "Conflict: Next", icon = "󰮰" },
    { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Conflict: Choose Ours", icon = "󰜞" },
    { "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", desc = "Conflict: Previous", icon = "󰮲" },
    { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Conflict: Choose Theirs", icon = "󰜙" },
  }
  require("git-conflict").setup {
    default_mappings = false,
  }
end

return M
