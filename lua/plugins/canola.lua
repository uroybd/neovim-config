local M = {
	"barrettruth/canola.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"barrettruth/canola-collection",
	},
	keys = {
		{ "-", "<CMD>Canola --float<CR>", desc = "Open parent directory" },
	},
	branch = "canola",
}

vim.g.canola = {
	columns = { "icon" },
	cursor = true,
	float = {
		border = "single",
		max_height = 20,
		max_width = 100,
	},
	hidden = {
		enabled = true,
	},
	keymaps = {
		gd = {
			desc = "Toggle file detail view",
		},
	},
	watch = false,
}
vim.g.canola_trash = {}

return M
