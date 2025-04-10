local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "AndreM222/copilot-lualine" },
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
      section_separators = { left = "", right = "" },

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
        -- { -- NeoCodeium Status
        --   function()
        --     local status, serverstatus = require("neocodeium").get_status()
        --
        --     -- Tables to map serverstatus and status to corresponding symbols
        --     local server_status_symbols = {
        --       [0] = "󰣺 ", -- Connected
        --       [1] = "󰣻 ", -- Connection Error
        --       [2] = "󰣽 ", -- Disconnected
        --     }
        --
        --     local status_symbols = {
        --       [0] = "󰚩 ", -- Enabled
        --       [1] = "󱚧 ", -- Disabled Globally
        --       [3] = "󱚢 ", -- Disabled for Buffer filetype
        --       [5] = "󱚠 ", -- Disabled for Buffer encoding
        --       [2] = "󱙻 ", -- Disabled for Buffer (catch-all)
        --     }
        --
        --     -- Handle serverstatus and status fallback (safeguard against any unexpected value)
        --     local luacodeium = server_status_symbols[serverstatus] or "󰣼 "
        --     luacodeium = luacodeium .. (status_symbols[status] or "󱚧 ")
        --
        --     return luacodeium
        --   end,
        --   cond = require("neocodeium").is_enabled,
        -- },
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
