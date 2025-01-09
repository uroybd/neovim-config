local M = {
  "neogitorg/neogit",
  event = "VeryLazy",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "ibhagwan/fzf-lua",
  },
}

function M.config()
  local icons = require "user.icons"
  local wk = require "which-key"
  wk.add {
    { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit", icon = "󰊢" },
  }

  require("neogit").setup {
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    graph_style = "kitty",
    -- Change the default way of opening neogit
    kind = "tab",
    -- Change the default way of opening the commit popup
    commit_popup = {
      kind = "split",
    },
    -- Change the default way of opening popups
    popup = {
      kind = "split",
    },
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
      item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
      hunk = { "", "" },
    },
    integrations = {
      diffview = true,
      fzf_lua = true,
    },
  }
end

return M
