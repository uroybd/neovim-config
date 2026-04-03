-- Disable auto-comment on new line
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Close certain filetypes with q
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

-- Close command-line window immediately
vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

-- Equalize window sizes on resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- Check for external file changes
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
  end,
})

-- Enable wrap and spell for certain filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Kulala-specific keybindings for http filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function()
    local wk = require "which-key"
    local buf = vim.api.nvim_get_current_buf()
    wk.add {
      {
        "<cr>",
        function()
          require("kulala").run()
        end,
        noremap = true,
        buffer = buf,
      },
      {
        "[",
        function()
          require("kulala").jump_prev()
        end,
        noremap = true,
        buffer = buf,
      },
      {
        "]",
        function()
          require("kulala").jump_next()
        end,
        noremap = true,
        buffer = buf,
      },
      {
        "<leader>i",
        function()
          require("kulala").inspect()
        end,
        noremap = true,
        buffer = buf,
      },
      {
        "t",
        function()
          require("kulala").toggle_view()
        end,
        noremap = true,
        buffer = buf,
      },
    }
  end,
})

-- Set commentstring for kdl files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "kdl",
  command = "silent! setlocal commentstring=//%s",
})

-- Unlink luasnip on cursor hold (if luasnip is installed)
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      vim.cmd [[silent! lua require("luasnip").unlink_current()]]
    end
  end,
})

-- Set filetype for NeogitCommitMessage
vim.api.nvim_create_augroup("neogit-additions", {})
vim.api.nvim_create_autocmd("FileType", {
  group = "neogit-additions",
  pattern = "NeogitCommitMessage",
  command = "silent! set filetype=gitcommit",
})

-- Dynamic cursorline underline based on column position
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
  callback = function()
    local col = vim.fn.virtcol(".")
    local colors = require("catppuccin.palettes").get_palette("frappe")
    
    if col >= 100 then
      -- Red underline after limit
      vim.api.nvim_set_hl(0, "CursorLine", { underline = true, sp = colors.red })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.red, bold = true })
    elseif col >= 90 then
      -- Yellow underline at 90%
      vim.api.nvim_set_hl(0, "CursorLine", { underline = true, sp = colors.yellow })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.yellow, bold = true })
    else
      -- Normal cursorline (no underline)
      vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.surface0 })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.lavender, bold = true })
    end
  end,
})
