local M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  version = "v2.*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    bigfile = {
      enabled = true,
    },
    input = {
      enabled = true,
    },
    indent = {
      enabled = true,
      chunk = {
        enabled = true,
        only_current = true,
        char = {
          corner_top = "╭",
          corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = "󰅂",
          -- arrow = ">",
        },
      },
    },
    notifier = {
      enabled = true,
    },
    git = {
      enabled = true,
    },
    gitbrowse = {
      enabled = true,
    },
    quickfile = {
      enabled = true,
    },
    statuscolumn = {
      enabled = true,
    },
    words = {
      enabled = true,
    },
    dashboard = {
      preset = {
        header = [[

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      sections = {
        {
          section = "terminal",
          cmd = "gh skyline -a | sed -r 's/\\.//g' | sed -e 's/^/   /'",
          -- pane = 2,
          height = 7,
          padding = 1,
        },
        { section = "header" },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        -- { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        -- {
        --   pane = 2,
        --   icon = " ",
        --   desc = "Browse Repo",
        --   padding = 1,
        --   key = "b",
        --   action = function()
        --     Snacks.gitbrowse()
        --   end,
        -- },
        -- function()
        --   local in_git = Snacks.git.get_root() ~= nil
        --   local cmds = {
        --     {
        --       title = "Notifications",
        --       cmd = "gh notify -s -a -n5",
        --       action = function()
        --         vim.ui.open "https://github.com/notifications"
        --       end,
        --       key = "n",
        --       icon = " ",
        --       height = 5,
        --       enabled = true,
        --     },
        --     {
        --       icon = " ",
        --       title = "Open PRs",
        --       cmd = "gh pr list -L 3",
        --       key = "p",
        --       action = function()
        --         vim.fn.jobstart("gh pr list --web", { detach = true })
        --       end,
        --       height = 7,
        --     },
        --     {
        --       title = "Open Issues",
        --       cmd = "gh issue list -L 3",
        --       key = "i",
        --       action = function()
        --         vim.fn.jobstart("gh issue list --web", { detach = true })
        --       end,
        --       icon = " ",
        --       height = 7,
        --     },
        --   }
        --   return vim.tbl_map(function(cmd)
        --     return vim.tbl_extend("force", {
        --       pane = 2,
        --       section = "terminal",
        --       enabled = in_git,
        --       padding = 1,
        --       ttl = 5 * 60,
        --       indent = 3,
        --     }, cmd)
        --   end, cmds)
        -- end,
        { section = "startup" },
      },
    },
  },
  keys = {
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>nh",
      function()
        Snack.notifier.show_history()
      end,
      desc = "Notifications",
    },
  },
}

return M
