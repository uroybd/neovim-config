local M = { "rose-pine/neovim", lazy = false, priority = 1000 }

function M.config()
	require("rose-pine").setup({
		variant = "auto",
		dark_variant = "moon",
		highlight_groups = {
			LineNrAbove = { fg = "iris" },
			LineNrBelow = { fg = "foam" },
		},
	})
	vim.cmd.colorscheme("rose-pine")
end

return M
