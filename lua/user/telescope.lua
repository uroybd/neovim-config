local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    { "scottmckendry/telescope-resession.nvim" },
  },
}

function M.config()
  require("telescope").load_extension "fzf"
  local wk = require "which-key"
  wk.add {
    { "<leader>bb", "<cmd>Telescope buffers previewer=false<cr>", desc = "Buffers", icon = "" },
    { "<leader>gC", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", icon = "󱓏" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files", icon = "󰈞" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help", icon = "󰞋" },
    { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search", icon = "󱘞" },
    {
      "<leader>fp",
      "<cmd>lua require('telescope').extensions.projects.projects()<cr>",
      desc = "Projects",
      icon = "",
    },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File", icon = "" },
    {
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_workspace_symbols {
          query = vim.fn.input "Symbol > ",
        }
      end,
      desc = "Find Symbol",
      icon = "",
    },
    { "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Find Text", icon = "󰺮" },
    {
      "<leader>s",
      function()
        require("telescope").extensions.resession.resession()
      end,
      desc = "Sessions",
      icon = "",
    },
  }
  local icons = require "user.icons"
  local actions = require "telescope.actions"

  require("telescope").setup {
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      },
    },
    pickers = {
      live_grep = {
        theme = "dropdown",
      },

      grep_string = {
        theme = "dropdown",
      },

      find_files = {
        theme = "dropdown",
        previewer = false,
      },

      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      resession = {
        prompt_title = "Find Sessions", -- telescope prompt title
        dir = "session", -- directory where resession stores sessions
        path_substitutions = {
          { find = "/Volumes/Repos/", replace = " " },
        },
      },
    },
  }
end

return M
