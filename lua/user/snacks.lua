local apidocs_dir = vim.fn.stdpath "data" .. "/apidocs-data/"

function load_doc_in_buffer(buf, filepath)
  if vim.fn.filereadable(filepath) == 1 then
    local lines = {}
    for line in io.lines(filepath) do
      -- nbsp so that neovim doesn't highlight this as a quoted paragraph
      table.insert(lines, (line:gsub("^    ", "    ")))
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    vim.bo[buf].filetype = "markdown"
  else
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "File not readable: " .. filepath })
  end
end

function buf_view_switch_to_new(new_buf)
  vim.wo.winfixbuf = false
  vim.api.nvim_win_set_buf(0, new_buf)
  vim.api.nvim_buf_set_option(0, "modifiable", false)
  vim.wo.winfixbuf = true
  vim.wo.wrap = false
  vim.bo.modified = false

  vim.keymap.set("n", "<C-o>", function()
    vim.wo.winfixbuf = false
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>", true, false, true), "n", true)
    vim.defer_fn(function()
      vim.wo.winfixbuf = true
    end, 100)
  end, { buffer = true })
end

function open_doc_in_new_window(docs_path)
  -- create a new window and use winfixbuf on it, because i'll set
  -- conceallevel, and that's tied to the window (not the buffer),
  -- and is very invasive
  vim.cmd [[100vsplit]]
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_win_set_buf(0, buf)
  vim.wo.conceallevel = 2
  vim.wo.concealcursor = "n"
  vim.wo.winfixbuf = true
  vim.wo.list = false
  load_doc_in_buffer(buf, docs_path)
  vim.api.nvim_buf_set_option(0, "modifiable", false)
  vim.wo.wrap = false
  vim.bo.modified = false

  vim.keymap.set("n", "<C-]>", function()
    local line = vim.api.nvim_buf_get_lines(0, vim.fn.line "." - 1, vim.fn.line ".", false)[1]
    local m = string.match(line, "^%s+%d+%. local://")
    if m == nil and vim.startswith(line, "\tlocal://") then
      -- sometimes the format is not "number. link", but "number. desc\n\tlink". maybe when the link has
      -- a description? this happens with rust
      m = string.match(line, "^\tlocal://")
    end
    if m then
      -- when parsing the local:// url, drop "<tab>+" text at the end,
      -- we add this marker when we can't resolve the ID reference
      local target = line:sub(#m + 1):gsub("\t%+.+$", "")
      local components = vim.split(target, "#")
      if #components == 2 then
        -- plain file name
        local new_buf = vim.api.nvim_create_buf(true, false)
        load_doc_in_buffer(new_buf, apidocs_dir .. target .. ".html.md")
        buf_view_switch_to_new(new_buf)
      elseif #components == 3 then
        -- file name+section ID
        local new_buf = vim.api.nvim_create_buf(true, false)
        load_doc_in_buffer(new_buf, apidocs_dir .. components[1] .. "#" .. components[2] .. ".html.md")
        buf_view_switch_to_new(new_buf)
        vim.cmd("/" .. components[3])
        -- put the match at the top of the screen, then scroll up one line <C-y>
        vim.cmd "norm! zt | "
      elseif #components == 4 then
        -- file name with two hashes+section ID (happens for lua)
        local new_buf = vim.api.nvim_create_buf(true, false)
        load_doc_in_buffer(
          new_buf,
          apidocs_dir .. components[1] .. "#" .. components[2] .. "#" .. components[3] .. ".html.md"
        )
        buf_view_switch_to_new(new_buf)
        vim.cmd("/" .. components[4])
        -- put the match at the top of the screen, then scroll up one line <C-y>
        vim.cmd "norm! zt | "
      end
    end
  end)
end

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
          preset = "sidebar",
          dirs = { apidocs_dir },
          ft = { "markdown", "md" },
          confirm = function(picker, item)
            open_doc_in_new_window(item.file)
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
