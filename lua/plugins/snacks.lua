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
		"folke/trouble.nvim",
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
				qflist = function(...)
					require("snacks.picker.actions").qflist(...)
					vim.cmd("cclose")
					vim.cmd("Trouble qflist open focus=true")
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
	})
end

return M
