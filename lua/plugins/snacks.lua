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
		"echasnovski/mini.icons",
	},
	priority = 1000,
	opts = {
		bigfile = {
			enabled = true,
		},
		image = {
			enabled = true,
			force = true,
			doc = {
				inline = true,
				math = true,
			},
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
				git_diff = {
					auto_close = false,
					layout = {
						preset = "left",
					},
					win = {
						preview = {
							keys = {
								["<tab>"] = { "list_down" },
								["<s-tab>"] = { "list_up" },
							},
						},
					},
				},
				gh_diff = {
					auto_close = false,
					layout = {
						preset = "left",
					},
					win = {
						preview = {
							keys = {
								["<tab>"] = { "list_down" },
								["<s-tab>"] = { "list_up" },
							},
						},
					},
				},
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
		scroll = {
			enabled = true,
		},
		words = {
			enabled = true,
		},
		gh = {
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
					height = 6,
					padding = 1,
					cmd = "nu --interactive --login -c 'commitart repo --even --dirty --centered-in=60 --block=\"══,║║,╠╣,╦╩,╬╬,╔╗,╚╝,╫╫,╪╪,▪▪,██,══,║║,╬╬,▪▪,██\"'; echo '\n\n\n'",
				},
				{
					section = "terminal",
					cmd = "nu --interactive --login -c 'jira me issues top'",
					title = "Jira Issues",
					height = 5,
					padding = 1,
					icon = "",
				},
				{ icon = "", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
			},
		},
	},
}

function M.config(_, opts)
	require("snacks").setup(opts)

	-- ghlite.nvim runs vim.ui.select through async.nvim, which treats any value
	-- the select fn returns as an owned closable and tries to close it (passing a
	-- callback it waits on) before resuming the task. snacks' vim.ui.select
	-- returns its picker object, whose :close() ignores that callback, so the
	-- async task hangs forever and GHLitePRSelect / GHLitePRCheckout silently do
	-- nothing. Wrap snacks' handler so it returns nothing.
	do
		local ok, picker = pcall(require, "snacks.picker")
		local function wrap_ui_select()
			if ok and vim.ui.select == picker.select then
				local snacks_ui_select = vim.ui.select
				vim.ui.select = function(items, select_opts, on_choice)
					snacks_ui_select(items, select_opts, on_choice)
				end
			end
		end
		wrap_ui_select() -- snacks already ran its UIEnter hook (vim_did_enter)
		vim.api.nvim_create_autocmd("UIEnter", { once = true, callback = vim.schedule_wrap(wrap_ui_select) })
	end

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

	-- Tab layout preview: draws a miniature of vim.fn.winlayout() with box characters
	local U, D, L, R = 1, 2, 4, 8
	local box_chars = {
		[0] = " ",
		"│",
		"│",
		"│",
		"─",
		"┘",
		"┐",
		"┤",
		"─",
		"└",
		"┌",
		"├",
		"─",
		"┴",
		"┬",
		"┼",
	}

	local node_size
	node_size = function(node)
		local kind, data = node[1], node[2]
		if kind == "leaf" then
			return vim.api.nvim_win_get_width(data), vim.api.nvim_win_get_height(data)
		end
		local w, h = 0, 0
		for _, child in ipairs(data) do
			local cw, ch = node_size(child)
			if kind == "row" then
				w, h = w + cw + 1, math.max(h, ch)
			else
				w, h = math.max(w, cw), h + ch + 1
			end
		end
		if kind == "row" then
			w = w - 1
		else
			h = h - 1
		end
		return w, h
	end

	local function win_label(win, active)
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.api.nvim_buf_get_name(buf)
		local bt = vim.bo[buf].buftype
		if bt == "terminal" then
			name = "[term]"
		elseif name == "" then
			name = bt ~= "" and ("[" .. bt .. "]") or "[No Name]"
		else
			name = vim.fn.fnamemodify(name, ":t")
		end
		return (active and "● " or "") .. name
	end

	-- cv.mask[y][x] holds line-segment bits, cv.text[y][x] holds label characters
	local function canvas_add(cv, x, y, mask)
		cv.mask[y][x] = bit.bor(cv.mask[y][x] or 0, mask)
	end

	local function draw_box(cv, x, y, w, h)
		for cx = x, x + w - 1 do
			local m = (cx > x and L or 0) + (cx < x + w - 1 and R or 0)
			canvas_add(cv, cx, y, m)
			canvas_add(cv, cx, y + h - 1, m)
		end
		for cy = y, y + h - 1 do
			local m = (cy > y and U or 0) + (cy < y + h - 1 and D or 0)
			canvas_add(cv, x, cy, m)
			canvas_add(cv, x + w - 1, cy, m)
		end
	end

	local function render_node(cv, node, x, y, w, h, active_win)
		local kind, data = node[1], node[2]
		if kind == "leaf" then
			draw_box(cv, x, y, w, h)
			if w >= 5 and h >= 3 then
				local chars = vim.fn.split(win_label(data, data == active_win), "\\zs")
				local room = w - 2
				if #chars > room then
					chars = vim.list_slice(chars, 1, room - 1)
					table.insert(chars, "…")
				end
				local ly = y + math.floor((h - 1) / 2)
				local lx = x + 1 + math.floor((room - #chars) / 2)
				for i, ch in ipairs(chars) do
					cv.text[ly][lx + i - 1] = ch
				end
			end
			return
		end

		-- children share their border line with the neighbour, hence span = size - 1
		local horiz = kind == "row"
		local weights, total = {}, 0
		for i, child in ipairs(data) do
			local cw, ch = node_size(child)
			weights[i] = horiz and cw or ch
			total = total + weights[i]
		end
		local span = (horiz and w or h) - 1
		local pos, acc = 0, 0
		for i, child in ipairs(data) do
			acc = acc + weights[i]
			local stop = span
			if i < #data then
				stop = math.min(span, math.max(pos + 2, math.floor(span * acc / total + 0.5)))
			end
			if horiz then
				render_node(cv, child, x + pos, y, stop - pos + 1, h, active_win)
			else
				render_node(cv, child, x, y + pos, w, stop - pos + 1, active_win)
			end
			pos = stop
		end
	end

	local function render_tab_layout(tabnr, max_w, max_h)
		local layout = vim.fn.winlayout(tabnr)
		local tabpage = vim.api.nvim_list_tabpages()[tabnr]
		local active_win = vim.api.nvim_tabpage_get_win(tabpage)

		-- terminal cells are ~twice as tall as wide, so halve the height ratio
		local tw, th = vim.o.columns, vim.o.lines - vim.o.cmdheight
		local w = math.max(10, max_w)
		local h = math.floor(w * th / tw / 2 + 0.5)
		if h > max_h then
			h = max_h
			w = math.floor(h * 2 * tw / th + 0.5)
		end
		w, h = math.max(w, 10), math.max(h, 3)

		local cv = { mask = {}, text = {} }
		for y = 1, h do
			cv.mask[y], cv.text[y] = {}, {}
		end
		render_node(cv, layout, 1, 1, w, h, active_win)

		local lines = {}
		local indent = string.rep(" ", math.max(0, math.floor((max_w - w) / 2)))
		for y = 1, h do
			local row = {}
			for x = 1, w do
				row[x] = cv.text[y][x] or box_chars[cv.mask[y][x] or 0]
			end
			lines[y] = indent .. table.concat(row)
		end
		return lines
	end

	-- Custom tab picker
	local function pick_tab()
		local items = {}
		local current_tab = vim.fn.tabpagenr()

		for i = 1, vim.fn.tabpagenr("$") do
			local wins = vim.fn.tabpagewinnr(i, "$")
			local bufnr = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
			local bufname = vim.fn.bufname(bufnr)
			local name = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"
			table.insert(items, {
				idx = i,
				tabnr = i,
				text = string.format("Tab %d: %s (%d windows)", i, name, wins),
				current = i == current_tab,
			})
		end

		Snacks.picker({
			title = "Tabs",
			items = items,
			format = function(item)
				return { { item.current and "● " or "  ", "SnacksPickerSpecial" }, { item.text } }
			end,
			preview = function(ctx)
				ctx.preview:reset()
				vim.wo[ctx.win].number = false
				vim.wo[ctx.win].relativenumber = false
				vim.wo[ctx.win].signcolumn = "no"
				ctx.preview:set_title("Tab " .. ctx.item.tabnr)
				local lines = render_tab_layout(
					ctx.item.tabnr,
					vim.api.nvim_win_get_width(ctx.win) - 2,
					vim.api.nvim_win_get_height(ctx.win) - 2
				)
				ctx.preview:set_lines(lines)
			end,
			layout = {
				layout = {
					box = "vertical",
					width = 64,
					height = math.min(#items, 8) + 12,
					border = "rounded",
					title = "{title}",
					title_pos = "center",
					{ win = "input", height = 1, border = "bottom" },
					{ win = "list", height = math.min(#items, 8), border = "none" },
					{ win = "preview", title = "{preview}", height = 8, border = "top" },
				},
			},
			win = {
				preview = {
					wo = { number = false, relativenumber = false, signcolumn = "no" },
				},
			},
			confirm = function(picker, item)
				picker:close()
				if item then
					vim.cmd("tabnext " .. item.tabnr)
				end
			end,
		})
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
			"<leader>tt",
			pick_tab,
			desc = "Tabs",
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
		{
			"<leader>gi",
			function()
				Snacks.picker.gh_issue()
			end,
			desc = "GitHub Issues (open)",
		},
		{
			"<leader>gI",
			function()
				Snacks.picker.gh_issue({ state = "all" })
			end,
			desc = "GitHub Issues (all)",
		},
		{
			"<leader>gp",
			function()
				Snacks.picker.gh_pr()
			end,
			desc = "GitHub Pull Requests (open)",
		},
		{
			"<leader>gP",
			function()
				Snacks.picker.gh_pr({ state = "all" })
			end,
			desc = "GitHub Pull Requests (all)",
		},
		{
			"<leader>gc",
			function()
				require("snacks").picker.git_status({})
			end,
			desc = "Git Status",
		},
	})

	local function pick_win()
		local win = Snacks.picker.util.pick_win()
		if win then
			vim.api.nvim_set_current_win(win)
		end
	end

	vim.keymap.set("n", "\\", pick_win, { desc = "Snacks Window Picker", noremap = true, silent = true })
	vim.keymap.set(
		{ "n", "i", "t" },
		"<C-Bslash>",
		pick_win,
		{ desc = "Snacks Window Picker", noremap = true, silent = true }
	)
end

return M
