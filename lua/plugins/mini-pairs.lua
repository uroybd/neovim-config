local M = {
	"echasnovski/mini.pairs",
	event = "InsertEnter",
	config = function()
		require("mini.pairs").setup()
	end,
}

return M
