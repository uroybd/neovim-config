local M = {
  "akinsho/git-conflict.nvim",
  event = "VeryLazy",
}

M.config = function()
  local wk = require("which-key")
  wk.register {
    ["<leader>gco"] = { "<cmd>GitConflictChooseOurs<cr>", "Conflict: Choose Ours" },
    ["<leader>gct"] = { "<cmd>GitConflictChooseTheirs<cr>", "Conflict: Choose Theirs" },
    ["<leader>gcb"] = { "<cmd>GitConflictChooseBoth<cr>", "Conflict: Choose Both" },
    ["<leader>gcn"] = { "<cmd>GitConflictNextConflict<cr>", "Conflict: Next" },
    ["<leader>gcp"] = { "<cmd>GitConflictPrevConflict<cr>", "Conflict: Previous" },
    ["<leader>gcl"] = { "<cmd>GitConflictListQf<cr>", "Conflict: List" },
  }

  require("git-conflict").setup({
    default_mappings = false,
  })
end

return M
