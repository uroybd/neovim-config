local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "codecompanion" },
}

function M.config()
  require("render-markdown").setup {}
end

return M
