-- Doom "In Your Face" diagnostics nag: a small floating face pinned to the
-- top-right of the editor, getting angrier as workspace errors pile up.

local IMAGE_DIR = vim.fn.stdpath("config") .. "/assets/images/inyourface/"
local FACES = { "doom0.png", "doom1.png", "doom2.png", "doom3.png" }

local FACE_WIDTH = 18
local FACE_HEIGHT = 9
-- Drop the face down a bit so it doesn't sit on top of / get clipped by the tabline.
local TOP_OFFSET = 1
-- Don't draw the face if the editor is too small to comfortably fit it.
local MIN_COLUMNS = 60
local MIN_LINES = 20

local state = {
	enabled = false,
	face_win = nil,
	placement = nil,
	visible = false,
	level = nil,
	last_columns = nil,
	last_lines = nil,
}

local function compute_level()
	local counts = vim.diagnostic.count(nil, { severity = vim.diagnostic.severity.ERROR })
	local total = counts[vim.diagnostic.severity.ERROR] or 0

	if total == 0 then
		return 1
	elseif total <= 2 then
		return 2
	elseif total <= 5 then
		return 3
	else
		return 4
	end
end

local function fits()
	return vim.o.columns >= MIN_COLUMNS and vim.o.lines >= MIN_LINES
end

local function close_face()
	if state.placement then
		pcall(function()
			state.placement:close()
		end)
		state.placement = nil
	end
	if state.face_win then
		pcall(function()
			state.face_win:close()
		end)
		state.face_win = nil
	end
	state.visible = false
	state.level = nil
end

local function show_face(level)
	close_face()

	local win = Snacks.win({
		relative = "editor",
		width = FACE_WIDTH,
		height = FACE_HEIGHT,
		row = TOP_OFFSET,
		col = vim.o.columns,
		anchor = "NE",
		border = "rounded",
		focusable = false,
		backdrop = false,
		zindex = 45,
		wo = { winblend = 0 },
		enter = false,
	})

	local ok, placement = pcall(Snacks.image.placement.new, win.buf, IMAGE_DIR .. FACES[level], { pos = { 1, 0 } })

	state.face_win = win
	if ok then
		state.placement = placement
		state.visible = true
		state.level = level
	else
		close_face()
	end
end

local function refresh()
	if not state.enabled then
		return
	end

	if not fits() then
		if state.visible then
			close_face()
		end
		return
	end

	local level = compute_level()
	local columns, lines = vim.o.columns, vim.o.lines
	local size_changed = columns ~= state.last_columns or lines ~= state.last_lines

	if not state.visible or state.level ~= level or size_changed then
		show_face(level)
		state.last_columns, state.last_lines = columns, lines
	end
end

local function toggle()
	if state.enabled then
		state.enabled = false
		close_face()
		return
	end

	state.enabled = true
	state.last_columns, state.last_lines = nil, nil
	refresh()
end

local group = vim.api.nvim_create_augroup("InYourFace", { clear = true })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	group = group,
	callback = refresh,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = group,
	callback = refresh,
})

vim.keymap.set("n", "<leader>uf", toggle, { desc = "Toggle In-Your-Face", noremap = true, silent = true })
