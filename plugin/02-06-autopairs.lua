vim.pack.add({
  {src="https://github.com/windwp/nvim-autopairs"}
})

require("nvim-autopairs").setup {
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
}
