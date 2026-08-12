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
		keywordStyle = { italic = true, bold = true },
		dimInactive = true,
		overrides = function(colors)
			-- Log colors to file
			return {
				LineNrAbove = { fg = colors.palette.green2 },
				LineNrBelow = { fg = colors.palette.blue2 },
				["@module"] = { fg = colors.palette.yellow },
			}
		end,
	})
	vim.cmd.colorscheme("kanso")
end

return M
