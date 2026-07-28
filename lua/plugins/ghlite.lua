local M = {
	"daliusd/ghlite.nvim",
	commit = "4b5b9b079df04bd68c69482fac80ac7af1a39a3b",
	dependencies = {
		-- "lewis6991/async.nvim",
		"esmuellert/codediff.nvim",
	},
	keys = {
		{ "<leader>us", ":GHLitePRSelect<cr>", silent = true, desc = "PR Select" },
		{ "<leader>uo", ":GHLitePRCheckout<cr>", silent = true, desc = "PR Checkout" },
		{ "<leader>uv", ":GHLitePRView<cr>", silent = true, desc = "PR View" },
		{ "<leader>uu", ":GHLitePRLoadComments<cr>", silent = true, desc = "PR Load Comments" },
		{ "<leader>up", ":GHLitePRDiff<cr>", silent = true, desc = "PR Diff" },
		{ "<leader>ul", ":GHLitePRDiffview<cr>", silent = true, desc = "PR Diffview" },
		{ "<leader>ua", ":GHLitePRAddComment<cr>", silent = true, desc = "PR Add comment" },
		{
			"<leader>ua",
			":GHLitePRAddComment<cr>",
			mode = "x",
			silent = true,
			desc = "PR Add comment",
		},
		{ "<leader>uc", ":GHLitePRUpdateComment<cr>", silent = true, desc = "PR Update comment" },
		{ "<leader>ud", ":GHLitePRDeleteComment<cr>", silent = true, desc = "PR Delete comment" },
		{ "<leader>ug", ":GHLitePROpenComment<cr>", silent = true, desc = "PR Open comment" },
	},
}

function M.config()
	require("ghlite").setup({
		diff_tool = "codediff",
	})
end

return M
