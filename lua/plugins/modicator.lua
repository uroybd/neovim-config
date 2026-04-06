local M = {
  "mawkler/modicator.nvim",
  event = "BufEnter",
  opts = {
    show_warnings = false,
    highlights = {
      defaults = {
        bold = true,
        italic = true,
      },
      use_cursorline_background = true,
    },
  },
}

function M.init()
  vim.o.cursorline = true
  vim.o.number = true
  vim.o.termguicolors = true
  vim.o.relativenumber = true
end

function M.config(_, opts)
  require("modicator").setup(opts)

  vim.api.nvim_create_autocmd({ "Colorscheme" }, {
    callback = function()
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#388bfd", bg = "NONE" })
    end,
  })
end

return M
