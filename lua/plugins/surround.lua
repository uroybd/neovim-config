local M = {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	opts = {},
}

function M.config(_, opts)
	require("nvim-surround").setup(opts)
end

return M
