vim.loader.enable()

-- Setup leader keys before zpack
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core configs
require("user.options")
require("user.keymaps")
require("user.autocmds")

-- Bootstrap zpack.nvim
vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' })

-- Setup zpack - automatically imports from lua/plugins/
require('zpack').setup({
  defaults = {
    confirm = true,
  },
  performance = {
    vim_loader = true,
  },
  cmd_prefix = 'Z',
})
