vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- Install parsers
vim.schedule(function()
	require("nvim-treesitter").install({
		"bash",
		"comment",
		"css",
		"diff",
		"dockerfile",
		"gitcommit",
		"gitignore",
		"git_config",
		"git_rebase",
		"go",
		"graphql",
		"html",
		"htmldjango",
		"http",
		"javascript",
		"json",
		"json5",
		"jsonc",
		"kdl",
		"lua",
		"make",
		"markdown",
		"markdown_inline",
		"nginx",
		"nu",
		"prisma",
		"python",
		"regex",
		"rust",
		"scss",
		"sql",
		"ssh_config",
		"svelte",
		"terraform",
		"toml",
		"typescript",
		"tsx",
		"vue",
		"xml",
		"yaml",
	})
end)

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local ft = vim.bo[buf].filetype

		-- Skip oil filetype
		if ft == "oil" then
			return
		end

		-- Disable on large files (>100KB)
		local max_filesize = 100 * 1024
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
			return
		end

		-- Enable treesitter highlighting
		pcall(vim.treesitter.start)
	end,
})

-- Enable treesitter-based folding
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local ft = vim.bo[buf].filetype

		-- Skip oil filetype
		if ft == "oil" then
			return
		end

		-- Enable folding
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
	end,
})

-- Enable treesitter-based indentation (experimental)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local ft = vim.bo[buf].filetype

		-- Skip oil filetype
		if ft == "oil" then
			return
		end

		-- NOTE: If Python indentation is problematic, uncomment the line below
		-- if ft == "python" then return end

		-- Enable treesitter indentation
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

