local M = {
	"rachartier/tiny-cmdline.nvim",
	lazy = false,
}

function M.config()
	require("vim._core.ui2").enable({})
	vim.o.cmdheight = 0
	require("tiny-cmdline").setup({
		on_reposition = require("tiny-cmdline").adapters.blink,
		position = {
			y = "20%",
		},
	})
end

return M
