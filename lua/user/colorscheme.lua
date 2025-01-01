local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  branch = "main",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  require("catppuccin").setup {
    flavour = "frappe", -- or "deep", "darker"
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
      }
    end,
    integrations = {
      beacon = true,
      colorful_winsep = true,
      dap = true,
      dap_ui = true,
      flash = true,
      gitsigns = true,
      grug_far = true,
      indent_blankline = {
        enabled = true,
        scope_color = "teal", -- catppuccin color (eg. `lavender`) Default: text
        colored_indent_levels = true,
      },
      lsp_saga = true,
      notify = true,
      nvimtree = true,
      nvim_surround = true,
      cmp = true,
      mason = true,
      markdown = true,
      neotest = true,
      noice = true,
      overseer = true,
      treesitter_context = true,
      fzf = true,
      treesitter = true,
      telescope = {
        enabled = true,
        -- style = "nvchad"
      },
      ufo = true,
      which_key = true,
    },
  }
  vim.cmd.colorscheme "catppuccin"
end

return M
