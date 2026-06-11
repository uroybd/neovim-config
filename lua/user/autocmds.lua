local function sync_theme_on_focus()
	local handle
	if vim.fn.has("mac") == 1 then
		handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
	elseif vim.fn.has("unix") == 1 then
		handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
	end

	if handle then
		local result = handle:read("*a")
		handle:close()

		local system_mode = result:match("[Dd]ark") and "dark" or "light"

		if vim.o.background ~= system_mode then
			vim.o.background = system_mode
			pcall(vim.cmd, "colorscheme " .. (vim.g.colors_name or "catppuccin"))
		end
	end
end

-- Create a single group for our workspace sync
local sync_group = vim.api.nvim_create_augroup("ZellijGhosttySync", { clear = true })

-- Handles both: Right after plugins load on startup, AND when switching windows mid-session
vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
	group = sync_group,
	callback = sync_theme_on_focus,
})

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

local project_folders = { "~/.config" }
local project_root_markers = { ".git", ".jj", "Cargo.toml", "pyproject.toml", "Makefile", "go.mod", "package.json" }
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("tiny-rooter", { clear = true }),
	callback = function()
		local bufpath = vim.fn.expand("%:p:h")
		local bufname = vim.fn.expand("%:p")
		-- Skip if it's not a real file
		if bufname == "" or vim.bo.buftype ~= "" then
			return
		end
		-- Check project_folders FIRST before looking for root markers
		for _, prefix in ipairs(project_folders) do
			local expanded_prefix = vim.fn.expand(prefix)
			if vim.startswith(bufpath, expanded_prefix) then
				local relative_path = bufpath:sub(#expanded_prefix + 1)
				local first_dir = relative_path:match("^/?([^/]+)")
				if first_dir then
					local new_root = expanded_prefix .. "/" .. first_dir
					if vim.fn.isdirectory(new_root) == 1 then
						vim.cmd.lcd(new_root)
						return
					end
				else
					vim.cmd.lcd(expanded_prefix)
					return
				end
			end
		end
		-- If not in a project_folder, then look for root markers
		local root = vim.fs.root(bufpath, project_root_markers)
		if root then
			vim.cmd.lcd(root)
		else
			-- Fallback to buffer's directory if no match
			vim.cmd.lcd(bufpath)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("MarkdownConceal", { clear = true }),
	pattern = { "markdown", "tex", "typst" },
	callback = function()
		vim.opt_local.conceallevel = 2
		vim.opt_local.concealcursor = "nv"
	end,
})
