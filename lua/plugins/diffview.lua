local M = {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
		{ "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
		{ "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
	},
}

function M.config()
	require("diffview").setup({
		enhanced_diff_hl = true,
		use_icons = true,
		merge_tool = {
			layout = "diff3_mixed",
			disable_diagnostics = true,
		},
		hooks = {
			view_opened = function(view)
				-- When a diff view opens, create an autocmd that resizes windows on Sidekick events
				vim.api.nvim_create_autocmd({ "WinNew", "WinClosed", "TermOpen" }, {
					-- Tie the autocommand group directly to this specific Diffview tab context
					group = vim.api.nvim_create_augroup("DiffviewTabResize_" .. view.tabpage, { clear = true }),
					callback = function()
						vim.schedule(function()
							if vim.api.nvim_tabpage_is_valid(view.tabpage) then
								vim.cmd("wincmd =")
							end
						end)
					end,
				})
			end,
			view_closed = function(view)
				-- Clean up the autocommand group when you close Diffview
				pcall(vim.api.nvim_del_augroup_by_name, "DiffviewTabResize_" .. view.tabpage)
			end,
		},
	})
end

return M
