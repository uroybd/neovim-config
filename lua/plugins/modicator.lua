local M = {
	"mawkler/modicator.nvim",
	event = "BufEnter",
	opts = {
		show_warnings = false,
		highlights = {
			defaults = {
				bold = true,
				italic = true,
			},
			use_cursorline_background = true,
		},
	},
}

function M.config(_, opts)
	vim.o.cursorline = true
	vim.o.number = true
	vim.o.termguicolors = true
	vim.o.relativenumber = true
	require("modicator").setup(opts)
end

return M
