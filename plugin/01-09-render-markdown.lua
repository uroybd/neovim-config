vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "codecompanion" },
  once = true,
  callback = function()
    vim.pack.add({
      {src="https://github.com/MeanderingProgrammer/render-markdown.nvim"}
    })
    
    require("render-markdown").setup {}
  end,
})
