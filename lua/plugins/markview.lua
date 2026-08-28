local M = {
	"OXY2DEV/markview.nvim",
	lazy = false,
}

function M.config()
	require("markview").setup({
		preview = {
			icon_provider = "mini",
		},
	})
end

return M
