local M = {
"folke/trouble.nvim",
 dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
}

M.config = function()
  local wk = require "which-key"
  wk.register {
    ["<leader>dt"] = { "<cmd>TroubleToggle<CR>", "Trouble" },
    ["<leader>dd"] = { "<cmd>TroubleToggle document_diagnostics<CR>", "Document Diagnostics" },
    ["<leader>dw"] = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Workspace Diagnostics" },
    ["<leader>dr"] = { "<cmd>TroubleToggle lsp_references<CR>", "References" },
    ["<leader>dq"] = { "<cmd>TroubleToggle quickfix<CR>", "Quickfix" },
  }

  require("trouble").setup ({
    position = "bottom",
    height = 15,
    icons = true,
    mode = "workspace_diagnostics",
    group = true,
    padding = true,
  })
end

return M
