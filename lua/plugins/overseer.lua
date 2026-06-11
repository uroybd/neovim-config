local M = {
	"stevearc/overseer.nvim",
	event = "VeryLazy",
}

function M.config()
	require("overseer").setup()

	local wk = require("which-key")
	wk.add({
		{ "<leader>T", group = "Tasks" },
		{ "<leader>Tt", "<cmd>OverseerToggle!<CR>", desc = "Toggle" },
		{ "<leader>Tr", "<cmd>OverseerOpen!<CR><cmd>OverseerRun<CR>", desc = "Run" },
		{ "<leader>Tn", "<cmd>OverseerOpen!<CR><cmd>OverseerRun TestNearest<CR>", desc = "Test Nearest" },
		{ "<leader>Tf", "<cmd>OverseerOpen!<CR><cmd>OverseerRun TestFile<CR>", desc = "Test File" },
	})
end

return M
