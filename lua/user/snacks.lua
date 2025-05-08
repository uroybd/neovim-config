local apidocs_dir = vim.fn.stdpath "data" .. "/apidocs-data/"

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
    explorer = {
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
        },
      },
    },
    notifier = {
      enabled = true,
    },
    picker = {
      enabled = true,
      ui_select = true,
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
      mode = { "n", "v" },
    },
    {
      "<leader>gl",
      function()
        Snacks.gitbrowse.open {
          open = function(url)
            vim.fn.setreg("+", url)
            vim.notify "Yanked url to clipboard"
          end,
        }
      end,
      desc = "Copy Git URL",
      mode = { "n", "v" },
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
      "<leader>e",
      function()
        Snacks.picker.explorer()
      end,
      desc = "Explorer",
    },
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
    {
      "<leader>sad",
      function()
        Snacks.picker.files {
          layout = {
            preview = true,
            preset = "telescope",
          },
          win = {
            preview = {
              wo = {
                number = true,
                relativenumber = false,
                signcolumn = "no",
                conceallevel = 2,
                concealcursor = "n",
                winfixbuf = true,
                list = false,
                wrap = false,
              },
            },
          },
          dirs = { apidocs_dir },
          ft = { "markdown", "md" },
          confirm = function(picker, item)
            require("apidocs").open_doc_in_new_window(item.file)
          end,
          format = function(item, picker)
            local parts = vim.split(item.file, "/")
            -- take the last part and set it as the text
            local folder = parts[#parts - 1]
            local filename = parts[#parts]
            local filetype = vim.split(folder, "~")[1]
            local icon, hl = Snacks.util.icon(filetype, "filetype", {
              fallback = picker.opts.icons.files,
            })
            icon = Snacks.picker.util.align(icon, picker.opts.formatters.file.icon_width or 2)
            filename = filename:gsub("%.html%.md$", "")
            local new_item = {
              {
                icon,
                hl,
                virtual = true,
              },
              {
                folder .. " | ",
                "SnacksPickerSpecial",
                field = "file",
              },
            }
            local fileNameParts = vim.split(filename, "#")
            -- loop through the parts and add them to the new_item
            for i = 1, #fileNameParts do
              local part = fileNameParts[i]
              new_item[#new_item + 1] = {
                part,
                "SnacksPickerFile",
                field = "file",
              }
              if i < #fileNameParts then
                new_item[#new_item + 1] = {
                  " > ",
                  "SnacksPickerDelim",
                  field = "file",
                }
              end
            end
            return new_item
          end,
        }
      end,
      desc = "API Docs",
    },
    {
      "<tab>",
      function()
        Snacks.picker.marks()
      end,
      desc = "Bookmarks",
    },
  },
}

return M
