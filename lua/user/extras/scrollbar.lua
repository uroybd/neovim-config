local M = {
  'petertriho/nvim-scrollbar',
  event = "VeryLazy",
  dependencies = {"lewis6991/gitsigns.nvim", "kevinhwang91/nvim-hlslens"}
}

function M.config()
  require("scrollbar").setup()
  require("scrollbar.handlers.search").setup({
        -- hlslens config overrides
    })
  require('gitsigns').setup()
  require("scrollbar.handlers.gitsigns").setup()
end

return M
