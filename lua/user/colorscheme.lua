local M = {
  -- "olimorris/onedarkpro.nvim",
"catppuccin/nvim",
name = "catppuccin",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  require("catppuccin").setup({
    flavour= "frappe", -- or "deep", "darker"
    styles = {
      comments = {"italic"},
      keywords = {"bold", "italic"},
      functions = {"italic"},
      parameters = {"italic"},
      strings = { "bold" },
      numbers = { "bold" },
      operators = { "bold" },
      properties = { "italic" },
      booleans = { "bold"},
    },
    integrations = {
      notify = true,
    }
  })
  vim.cmd.colorscheme "catppuccin"
end

return M
