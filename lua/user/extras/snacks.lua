local M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  version = "v2.*",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    bigfile = {
      enabled = true
    },
    input = {
      enabled = true
    },
    indent = {
      enabled = true,
      chunk = {
        enabled = true,
        only_current = true
      }
    },
    notifier = {
      enabled = false,
    },
    git = {
      enabled = true,
    },
    gitbrowse = {
      enabled = true,
    },
    quickfile = {
      enabled = true
    },
    statuscolumn = {
      enabled = true,
      left = {"git", "fold"},
      right = {"sign", "mark"},
      folds = {
        git_hl = true
      }
    },
    words = {
      enabled = true
    }
  },
  keys = {
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
  }
}


return M
