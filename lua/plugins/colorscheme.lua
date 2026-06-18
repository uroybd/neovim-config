local M = {
	"webhooked/kanso.nvim",
	lazy = false,
	priority = 1000,
}

function M.config()
	require("kanso").setup({
		compile = true,
		background = {
			dark = "mist",
			light = "pearl",
		},
		-- dimInactive = true,
	})
	vim.cmd.colorscheme("kanso")
end

return M
