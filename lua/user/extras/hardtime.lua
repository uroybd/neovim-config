local M = {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
}

function M.config()
  require("hardtime").setup {
    disable_mouse = false,
    disabled_filetypes = {
      "qf",
      "netrw",
      "NvimTree",
      "lazy",
      "mason",
      "oil",
      "sagadiagnostic",
      "sagafinder",
      "sagatypehierarchy",
      "sagarename",
      "saga_unitest",
    },
  }
end

return M
