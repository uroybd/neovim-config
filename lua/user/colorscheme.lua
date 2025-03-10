local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  branch = "main",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  require("catppuccin").setup {
    flavour = "frappe",
    styles = {
      comments = { "italic" },
      keywords = { "bold", "italic" },
      functions = { "italic" },
      parameters = { "italic" },
      -- strings = { "bold" },
      -- numbers = { "bold" },
      -- operators = { "bold" },
      properties = { "italic" },
      -- booleans = { "bold" },
    },
    custom_highlights = function(colors)
      return {
        LineNrAbove = { fg = colors.flamingo },
        LineNrBelow = { fg = colors.teal },
        NormalFloat = { bg = colors.base, fg = colors.text },
        ["@attribute.diff"] = { fg = colors.peach, style = { "underline", "bold" } },
      }
    end,
    integrations = {
      beacon = true,
      blink_cmp = true,
      colorful_winsep = true,
      flash = true,
      gitsigns = true,
      grug_far = true,
      lsp_saga = true,
      notify = true,
      nvimtree = true,
      nvim_surround = true,
      mason = true,
      markdown = true,
      neogit = true,
      overseer = true,
      treesitter_context = true,
      treesitter = true,
      ufo = true,
      which_key = true,
      snacks = true,
    },
  }
  vim.cmd.colorscheme "catppuccin"
end

return M
