vim.api.nvim_create_autocmd("BufEnter", {
  once = true,
  callback = function()
    vim.pack.add({
      {src="https://github.com/mawkler/modicator.nvim"}
    })

    require("modicator").setup {
      show_warnings = false,
      highlights = {
        defaults = {
          bold = true,
          italic = true,
        },
        use_cursorline_background = true,
      },
      init = function()
        -- These are required for Modicator to work
        vim.o.cursorline = true
        vim.o.number = true
        vim.o.termguicolors = true
        vim.o.relativenumber = true
      end,
    }

    vim.api.nvim_create_autocmd({ "Colorscheme" }, {
      callback = function()
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#388bfd", bg = "NONE" })
      end,
    })
  end,
})
