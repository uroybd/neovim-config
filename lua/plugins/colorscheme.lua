local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Load colorscheme early
  opts = {
    flavour = "frappe",
    styles = {
      comments = { "italic" },
      keywords = { "bold", "italic" },
      functions = { "italic" },
      parameters = { "italic" },
      properties = { "italic" },
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
  },
}

function M.config(_, opts)
  require("catppuccin").setup(opts)
  vim.cmd.colorscheme("catppuccin-nvim")
end

return M
