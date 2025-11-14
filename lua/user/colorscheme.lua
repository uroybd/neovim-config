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
        FloatBorder = { bg = "NONE" },
        TablineFill = { bg = colors.base },
        ["@attribute.diff"] = { fg = colors.peach, style = { "underline", "bold" } },
        ["@module"] = { fg = colors.sapphire },
      }
    end,
    integrations = {
      beacon = true,
      colorful_winsep = true,
      copilot_vim = true,
      diffview = true,
      flash = true,
      gitsigns = true,
      grug_far = true,
      noice = true,
      notify = true,
      nvimtree = true,
      nvim_surround = true,
      mason = true,
      markdown = true,
      neogit = true,
      overseer = true,
      render_markdown = true,
      snacks = {
        enabled = true,
        indent_scope_color = "sapphire",
      },
      treesitter_context = true,
      treesitter = true,
      ufo = true,
      which_key = true,
    },
  }
  vim.cmd.colorscheme "catppuccin"
end

return M
