vim.schedule(function()
  vim.pack.add({
    {src="https://github.com/DrKJeff16/project.nvim"}
  })

  require("project").setup {}
end)
