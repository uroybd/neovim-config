local M = {
	"nvim-mini/mini.surround",
	event = "VeryLazy",
	opts = {},
}

function M.config()
	require("mini.surround").setup({
		mappings = {
			add = "gsa",
			delete = "gsd",
			find = "gsf",
			find_left = "gsF",
			highlight = "gsh",
			replace = "gsr",
		},
	})
end

return M
