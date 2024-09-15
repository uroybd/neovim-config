vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

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

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Autocmd to create kulala-specific whichkey bindings for http filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function()
    local wk = require("which-key");
    local buf = vim.api.nvim_get_current_buf();
    wk.add({
      {"<cr>", function() require('kulala').run() end, noremap = true, buffer = buf},
      {"[", function() require('kulala').jump_prev() end, noremap = true, buffer = buf},
      {"]", function() require('kulala').jump_next() end, noremap = true, buffer = buf},
      {"<leader>i", function() require('kulala').inspect() end, noremap = true, buffer = buf},
      {"t", function() require('kulala').toggle_view() end, noremap = true, buffer = buf},
    })
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      -- ask maintainer for option to make this silent
      -- luasnip.unlink_current()
      vim.cmd [[silent! lua require("luasnip").unlink_current()]]
    end
  end,
})


vim.api.nvim_create_augroup("neogit-additions", {})
vim.api.nvim_create_autocmd("FileType", {
		group = "neogit-additions",
		pattern = "NeogitCommitMessage";
		command = "silent! set filetype=gitcommit",
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp", { clear = true }),
--   callback = function(args)
--     -- 2
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       -- 3
--       buffer = args.buf,
--       callback = function()
--         -- 4 + 5
--         vim.lsp.buf.format {async = false, id = args.data.client_id }
--       end,
--     })
--   end
-- })
