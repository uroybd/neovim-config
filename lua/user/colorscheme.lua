local M = {
  "olimorris/onedarkpro.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  require("onedarkpro").setup({
    theme = "onedark", -- or "deep", "darker"
    styles = {
      comments = "italic",
      keywords = "bold,italic",
      functions = "italic",
      parameters = "italic",
    },
  })
  vim.cmd.colorscheme "onedark"
end

return M
