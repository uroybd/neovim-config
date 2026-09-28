local M = {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
		{ "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
		{ "<leader>gdm", "<cmd>DiffviewOpen main<cr>", desc = "Open Diffview Main" },
		{ "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
	},
}

local function refresh_diffview()
	vim.schedule(function()
		-- 1. Verify if diffview's core library is loaded
		local has_lib, lib = pcall(require, "diffview.lib")
		if not has_lib then
			return
		end

		-- 2. Check if a diffview workspace is actively open right now
		if lib.get_current_view() then
			-- 3. Execute the official user command instead of a nil Lua field
			vim.cmd("DiffviewRefresh")
		end
	end)
end

function M.config()
	require("diffview").setup({
		enhanced_diff_hl = true,
		use_icons = true,
		keymaps = {
			view = {
				{ "n", "<leader>dr", "<Cmd>DiffviewRefresh<CR>", { desc = "Refresh diffview" } },
			},
			file_panel = {
				{ "n", "<leader>dr", "<Cmd>DiffviewRefresh<CR>", { desc = "Refresh diffview" } },
			},
		},
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

	vim.api.nvim_create_augroup("SidekickDiffviewSync", { clear = true })

	-- 1. Hook into sidekick's explicit completion event
	vim.api.nvim_create_autocmd("User", {
		group = "SidekickDiffviewSync",
		pattern = "SidekickNesDone",
		callback = refresh_diffview,
	})

	-- 2. Hook into Focus/Win changes for terminal CLI execution
	-- (Ensures changes drop smoothly when hopping back to code from sidekick windows)
	vim.api.nvim_create_autocmd({ "FocusGained", "WinEnter" }, {
		group = "SidekickDiffviewSync",
		callback = refresh_diffview,
	})
end

return M
