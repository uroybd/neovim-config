vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  once = true,
  callback = function()
    vim.pack.add({
      {src="https://github.com/OXY2DEV/helpview.nvim"}
    })
  end,
})
