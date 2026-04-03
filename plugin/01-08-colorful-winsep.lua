vim.api.nvim_create_autocmd("WinLeave", {
  once = true,
  callback = function()
    vim.pack.add({
      {src="https://github.com/nvim-zh/colorful-winsep.nvim"}
    })
    
    require("colorful-winsep").setup({
      -- hi = {
      --   fg = "#7287fd"
      -- }
    })
  end,
})
