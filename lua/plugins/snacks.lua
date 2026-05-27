local diagnostics_source_config = {
	layout = {
		preset = "ivy",
		layout = {
			height = 0.3,
		},
	},
}

local M = {
	"folke/snacks.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	priority = 1000,
	opts = {
		bigfile = {
			enabled = true,
		},
		input = {
			enabled = true,
		},
		indent = {
			enabled = true,
			chunk = {
				enabled = true,
				only_current = true,
				char = {
					corner_top = "╭",
					corner_bottom = "╰",
					horizontal = "─",
					vertical = "│",
					arrow = "󰅂",
				},
			},
		},
		notifier = {
			enabled = true,
		},
		picker = {
			enabled = true,
			ui_select = true,
			matcher = {
				frecency = true,
			},
			sources = {
				files = {
					layout = {
						preview = false,
						preset = "dropdown",
					},
				},
				buffers = {
					layout = {
						preview = false,
						preset = "dropdown",
					},
				},
				diagnostics = diagnostics_source_config,
				diagnostics_buffer = diagnostics_source_config,
			},
			actions = {
				sidekick_send = function(...)
					return require("sidekick.cli.picker.snacks").send(...)
				end,
			},
			win = {
				input = {
					keys = {
						["<a-a>"] = {
							"sidekick_send",
							mode = { "n", "i" },
						},
					},
				},
			},
		},
		git = {
			enabled = true,
		},
		gitbrowse = {
			enabled = true,
		},
		quickfile = {
			enabled = true,
		},
		statuscolumn = {
			enabled = true,
		},
		words = {
			enabled = true,
		},
		dashboard = {
			enabled = true,
			preset = {
				header = [[

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
			},
			sections = {
				{
					section = "terminal",
					cmd = "gh skyline -a | sed -r 's/\\.//g' | sed -e 's/^/   /'",
					height = 7,
					padding = 1,
				},
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
			},
		},
	},
}

function M.config(_, opts)
	require("snacks").setup(opts)

	-- Peek definition in a floating window
	local function peek_definition()
		local params = vim.lsp.util.make_position_params()
		vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, config)
			if err or not result or vim.tbl_isempty(result) then
				vim.notify("No definition found", vim.log.levels.WARN)
				return
			end

			local location = result[1] or result
			local uri = location.uri or location.targetUri
			local range = location.range or location.targetSelectionRange

			-- Get file path from URI
			local filepath = vim.uri_to_fname(uri)
			local bufnr = vim.fn.bufadd(filepath)
			vim.fn.bufload(bufnr)

			-- Get the lines to display (with context)
			local start_line = range.start.line
			local context_lines = 10
			local from_line = math.max(0, start_line - context_lines)
			local to_line = start_line + context_lines
			local lines = vim.api.nvim_buf_get_lines(bufnr, from_line, to_line + 1, false)

			-- Create a floating window with Snacks
			local win = Snacks.win({
				file = filepath,
				width = 0.6,
				height = 0.6,
				border = "rounded",
				title = " Definition: " .. vim.fn.fnamemodify(filepath, ":~:.") .. " ",
				title_pos = "center",
				wo = {
					number = true,
					relativenumber = false,
					wrap = false,
					cursorline = true,
				},
				keys = {
					q = "close",
					["<Esc>"] = "close",
				},
			})

			-- Set cursor to the definition line
			if win and win.win and vim.api.nvim_win_is_valid(win.win) then
				vim.api.nvim_win_set_cursor(win.win, { start_line + 1, range.start.character })
				-- Center the cursor line
				vim.api.nvim_win_call(win.win, function()
					vim.cmd("normal! zz")
				end)
			end
		end)
	end

	local wk = require("which-key")
	wk.add({
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>gl",
			function()
				Snacks.gitbrowse.open({
					open = function(url)
						vim.fn.setreg("+", url)
						vim.notify("Yanked url to clipboard")
					end,
				})
			end,
			desc = "Copy Git URL",
			mode = { "n", "v" },
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>nh",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notifications",
		},
		{
			"<leader>bb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fl",
			function()
				Snacks.picker.resume()
			end,
			desc = "Last Search",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent File",
		},
		{
			"<leader>ft",
			function()
				Snacks.picker.grep({ layout = { preset = "dropdown" } })
			end,
			desc = "Find Text",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Find Symbol",
		},
		{
			"<leader>gC",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Checkout branch",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help",
		},
		{
			"<leader>m",
			function()
				Snacks.picker.marks()
			end,
			desc = "Bookmarks",
			mode = { "n", "v" },
		},
		{
			"<leader>qq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>lci",
			function()
				Snacks.picker.lsp_incoming_calls()
			end,
			desc = "Incoming Calls",
		},
		{
			"<leader>lco",
			function()
				Snacks.picker.lsp_outgoing_calls()
			end,
			desc = "Outgoing Calls",
		},
		{
			"<leader>lr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "References",
		},
		{
			"<leader>lo",
			function()
				Snacks.picker.lsp_symbols({ layout = "right" })
			end,
			desc = "Outline",
		},
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions({ auto_confirm = true })
			end,
			desc = "Go to Definition",
		},
		{
			"<leader>fu",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<leader>dd",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>dw",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics (Workspace)",
		},
		{
			"gD",
			peek_definition,
			desc = "Peek Definition",
		},
	})
end

return M
