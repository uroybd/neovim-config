return {
  (function()
    local M = {
      "neogitorg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "esmuellert/codediff.nvim",
      },
      cmd = "Neogit",
      keys = {
        {
          "<leader>gg",
          function()
            require("neogit").open()
          end,
          desc = "Neogit",
        },
      },
    }

    function M.config()
      local icons = require("user.icons")

      require("neogit").setup({
        auto_refresh = true,
        disable_builtin_notifications = false,
        use_magit_keybindings = false,
        graph_style = "kitty",
        integrations = {
          codediff = true,
          snacks = true,
        },
        diff_viewer = "codediff",
        kind = "tab",
        commit_popup = {
          kind = "split",
        },
        popup = {
          kind = "split",
        },
        signs = {
          section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
          item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
          hunk = { "", "" },
        },
      })
    end

    return M
  end)(),
  {
    "nvim-lua/plenary.nvim",
  },
}
