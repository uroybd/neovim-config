local M = {
	"webhooked/kanso.nvim",
	lazy = false,
	priority = 1000,
}

function M.config()
	require("kanso").setup({
		background = {
			dark = "ink",
			light = "pearl",
		},
		dimInactive = true,
	})
	vim.cmd.colorscheme("kanso")
end

return M
