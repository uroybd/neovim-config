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
    picker = {
      matcher = {
        frecency = true,
      },
      sources = {
        files = {
          layout = {
            preview = false,
            preset = "dropdown",
          },
        },
        buffers = {
          layout = {
            preview = false,
            preset = "dropdown",
          },
        },
      },
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
        Snacks.notifier.show_history()
      end,
      desc = "Notifications",
    },
    -- Pickers
    {
      "<leader>bb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fl",
      function()
        Snacks.picker.resume()
      end,
      desc = "Last Search",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent File",
    },
    {
      "<leader>ft",
      function()
        Snacks.picker.grep { layout = { preset = "dropdown" } }
      end,
      desc = "Find Text",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "Find Symbol",
    },
    {
      "<leader>gC",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Checkout branch",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help",
    },
  },
}

return M
