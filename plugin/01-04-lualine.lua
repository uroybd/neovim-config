vim.pack.add({
  "https://github.com/AndreM222/copilot-lualine",
  "https://github.com/nvim-lualine/lualine.nvim",
})


local mode_icons = {
  NORMAL = "",
  INSERT = "󰗧",
  VISUAL = "󰒅",
  ["V-LINE"] = "󰿚",
  ["V-BLOCK"] = "󰾂",
  ["O-PENDING"] = "",
  SELECT = "󰲏",
  ["S-LINE"] = "󰿚",
  ["S-BLOCK"] = "󰾂",
  REPLACE = "",
  ["V-REPLACE"] = "",
  TERMINAL = "",
  COMMAND = "",
  EX = "",
  SHELL = "",
  MORE = "",
  CONFIRM = "",
}

local custom_catppuccin = require "lualine.themes.catppuccin-nvim"
custom_catppuccin.normal.c.bg = "#2f3446"
custom_catppuccin.normal.b.bg = "#414559"
custom_catppuccin.insert.b.bg = "#414559"
custom_catppuccin.visual.b.bg = "#414559"
custom_catppuccin.replace.b.bg = "#414559"
custom_catppuccin.command.b.bg = "#414559"
custom_catppuccin.terminal.b.bg = "#414559"
custom_catppuccin.inactive.a.bg = "#2f3446"
custom_catppuccin.inactive.b.bg = "#2f3446"
custom_catppuccin.inactive.a.bg = "#2f3446"

local blue = "#89b5f9"

require("lualine").setup {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = " ", right = " " },

      ignore_focus = { "NvimTree" },
      -- theme = "catppuccin",
      theme = custom_catppuccin,
    },
    tabline = {
      lualine_a = {
        {
          function()
            return "󰓩"
          end,
        },
        { "tabs", mode = 2, symbols = { modified = "●" } },
      },
      lualine_z = {
        "buffers",
        {
          function()
            return ""
          end,
          color = { bg = blue },
        },
      },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            local icon = mode_icons[str] or ""
            return icon .. " " .. str
          end,
        },
      },
      lualine_b = {
        "branch",
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
        },
        "diagnostics",
        { "filename", path = 4 },
      },
      lualine_c = {},
      lualine_x = {
        "selectioncount",
        "searchcount",
      },
      lualine_y = {
        "copilot",
        "filetype",
      },
      lualine_z = {
        "location",
        "progress",
      },
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
