local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
}

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

function M.config()
  require("lualine").setup {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },

      ignore_focus = { "NvimTree" },
      theme = "catppuccin",
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
      },
      lualine_c = { { "filename", path = 4 } },
      lualine_x = {
        "copilot",
        "filetype",
      },
      lualine_y = { "searchcount" },
      lualine_z = {
        "selectioncount",
        "location",
        "progress",
      },
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M
