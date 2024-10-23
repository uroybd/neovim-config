local M = {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
}

function M.config()
  require("hardtime").setup {
    disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
  }
end

return M
