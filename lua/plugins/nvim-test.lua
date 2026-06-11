local M = {
	"klen/nvim-test",
	config = function()
		require("nvim-test").setup()
	end,
	keys = {
		{ "<leader>rn", "<cmd>TestNearest<CR>", desc = "Run Nearest Test" },
		{ "<leader>rN", "<cmd>TestLast<CR>", desc = "Run Last Test" },
		{ "<leader>rf", "<cmd>TestFile<CR>", desc = "Run File Tests" },
		{ "<leader>ra", "<cmd>TestSuite<CR>", desc = "Run All Tests" },
		{ "<leader>ro", "<cmd>TestVisit<CR>", desc = "Open Test Output" },
	},
}

return M
