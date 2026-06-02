local M = {
	"WantDead/theme-sync.nvim",
	lazy = false,
}

function M.config(_)
	require("theme-sync").setup({
		on_change = function(_)
			require("lualine").refresh()
		end,
		dark = "catppuccin-frappe",
		light = "catppuccin-latte",
	})
end

return M
