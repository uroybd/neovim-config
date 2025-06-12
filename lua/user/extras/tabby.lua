local M = {
  "nanozuki/tabby.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}

local theme = {
  fill = "TabLineFill",
  head = { fg = "#8aadf4", bg = "#24273a", style = "italic" },
  current_tab = { fg = "#1e2030", bg = "#dd7878", style = "italic" },
  tab = { fg = "#8aadf4", bg = "#24273a", style = "italic" },
  current_win = { fg = "#1e2030", bg = "#dd7878", style = "italic" },
  win = { fg = "#1e2030", bg = "#8aadf4", style = "italic" },
  tail = { fg = "#8aadf4", bg = "#24273a", style = "italic" },
}

function M.config()
  require("tabby").setup {
    line = function(line)
      return {
        {
          { "  ", hl = theme.head },
          line.sep(" ", theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            line.sep(" ", hl, theme.fill),
            tab.is_current() and " " or "󰆣 ",
            tab.number(),
            tab.name(),
            tab.close_btn "",
            line.sep(" ", hl, theme.fill),
            hl = hl,
            margin = " ",
          }
        end),
        line.spacer(),
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
          local hl = win.is_current() and theme.current_win or theme.win
          return {
            line.sep(" ", hl, theme.fill),
            win.is_current() and " " or " ",
            win.buf_name(),
            line.sep(" ", hl, theme.fill),
            hl = hl,
            margin = " ",
          }
        end),
        {
          line.sep(" ", theme.tail, theme.fill),
          { "  ", hl = theme.tail },
        },
        hl = theme.fill,
      }
    end,
    -- option = {}, -- setup modules' option,
  }
  local wk = require "which-key"
  wk.add {
    { "<leader>aj", "<cmd>Tabby jump_to_tab<cr>", desc = "Jump to tab" },
    {
      "<leader>ar",
      function()
        local tab_name = vim.fn.input("Tab name", "")
        if tab_name then
          require("tabby").tab_rename(tab_name)
        end
      end,
      desc = "Rename tab",
    },
  }
end

return M
