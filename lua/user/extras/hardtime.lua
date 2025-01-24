local M = {
  "m4xshen/hardtime.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  require("hardtime").setup {
    disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
  }
end

return M
