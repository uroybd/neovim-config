-- Disable auto-comment on new line
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
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
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
	end,
})

-- Close command-line window immediately
vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	callback = function()
		vim.cmd("quit")
	end,
})

-- Equalize window sizes on resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Check for external file changes
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd("checktime")
	end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 40 })
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
		local wk = require("which-key")
		local buf = vim.api.nvim_get_current_buf()
		wk.add({
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
		})
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
			vim.cmd([[silent! lua require("luasnip").unlink_current()]])
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

-- Shamelessly copied from https://github.com/swaits/tiny-rooter.nvim
local project_root_markers = { ".git", ".jj", "Cargo.toml", "pyproject.toml", "Makefile", "go.mod", "package.json" }
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("tiny-rooter", { clear = true }),
	callback = function()
		local root = vim.fs.root(0, project_root_markers)
		if root then
			vim.cmd.lcd(root)
		end
	end,
})
