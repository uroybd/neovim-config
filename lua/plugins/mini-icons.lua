local M = {
	"echasnovski/mini.icons",
	branch = "main",
	lazy = false, -- Load early so other plugins can access icons instantly
	opts = {},
}

function M.config(_, opts)
	local mini_icons = require("mini.icons")
	mini_icons.setup(opts)
	mini_icons.mock_nvim_web_devicons()
end

return M
