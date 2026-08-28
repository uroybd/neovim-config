local M = {
	"daliusd/ghlite.nvim",
	dependencies = {
		"lewis6991/async.nvim",
		"esmuellert/codediff.nvim",
	},
	keys = {
		{ "<leader>us", ":GHLitePRSelect<cr>", silent = true, desc = "PR Select" },
		{ "<leader>uo", ":GHLitePRCheckout<cr>", silent = true, desc = "PR Checkout" },
		{ "<leader>uv", ":GHLitePRView<cr>", silent = true, desc = "PR View" },
		{ "<leader>ucc", ":GHLitePRLoadComments<cr>", silent = true, desc = "PR Load Comments" },
		{ "<leader>ul", ":GHLitePRDiffview<cr>", silent = true, desc = "PR Diffview" },
		{ "<leader>uca", ":GHLitePRAddComment<cr>", silent = true, desc = "PR Add comment" },
		{
			"<leader>uca",
			":GHLitePRAddComment<cr>",
			mode = "x",
			silent = true,
			desc = "PR Add comment",
		},
		{ "<leader>ucu", ":GHLitePRUpdateComment<cr>", silent = true, desc = "PR Update comment" },
		{ "<leader>ucd", ":GHLitePRDeleteComment<cr>", silent = true, desc = "PR Delete comment" },
		{ "<leader>ucg", ":GHLitePROpenComment<cr>", silent = true, desc = "PR Open comment" },
	},
}

function M.config()
	require("ghlite").setup({
		diff_tool = "codediff",
	})

	local wk = require("which-key")
	wk.add({
		{
			"<leader>uc",
			name = "PR Comments",
		},
	})
end

return M
