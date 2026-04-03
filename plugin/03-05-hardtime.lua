vim.schedule(function()
  vim.pack.add({
    {src="https://github.com/m4xshen/hardtime.nvim"}
  })

  require("hardtime").setup {}
end)
