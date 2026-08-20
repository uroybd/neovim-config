-- Doom "In Your Face" diagnostics nag: a small floating face pinned to the
-- bottom-right of the current window, getting angrier as workspace errors pile up.

local IMAGE_DIR = vim.fn.stdpath("config") .. "/assets/images/inyourface/"
local FACES = { "doom0.png", "doom1.png", "doom2.png", "doom3.png" }

local FACE_WIDTH = 18
local FACE_HEIGHT = 9
-- Lift the face up a bit so it doesn't sit on top of / get clipped by the statusbar.
local BOTTOM_OFFSET = 1
-- Don't draw the face in a window too small to comfortably fit it.
local MIN_WIN_WIDTH = 60
local MIN_WIN_HEIGHT = 20

local state = {
	enabled = false,
	host_win = nil,
	face_win = nil,
	placement = nil,
	visible = false,
	level = nil,
	last_width = nil,
	last_height = nil,
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

local function fits(win)
	if not win or not vim.api.nvim_win_is_valid(win) then
		return false
	end
	return vim.api.nvim_win_get_width(win) >= MIN_WIN_WIDTH and vim.api.nvim_win_get_height(win) >= MIN_WIN_HEIGHT
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

local function show_face(host_win, level)
	close_face()

	local win = Snacks.win({
		relative = "win",
		win = host_win,
		width = FACE_WIDTH,
		height = FACE_HEIGHT,
		row = vim.api.nvim_win_get_height(host_win) - BOTTOM_OFFSET,
		col = vim.api.nvim_win_get_width(host_win),
		anchor = "SE",
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

	if not state.host_win or not vim.api.nvim_win_is_valid(state.host_win) then
		close_face()
		state.enabled = false
		state.host_win = nil
		return
	end

	if not fits(state.host_win) then
		if state.visible then
			close_face()
		end
		return
	end

	local level = compute_level()
	local width = vim.api.nvim_win_get_width(state.host_win)
	local height = vim.api.nvim_win_get_height(state.host_win)
	local size_changed = width ~= state.last_width or height ~= state.last_height

	if not state.visible or state.level ~= level or size_changed then
		show_face(state.host_win, level)
		state.last_width, state.last_height = width, height
	end
end

local function toggle()
	if state.enabled then
		state.enabled = false
		state.host_win = nil
		close_face()
		return
	end

	state.enabled = true
	state.host_win = vim.api.nvim_get_current_win()
	state.last_width, state.last_height = nil, nil
	refresh()
end

local group = vim.api.nvim_create_augroup("InYourFace", { clear = true })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	group = group,
	callback = refresh,
})

vim.api.nvim_create_autocmd({ "VimResized", "WinResized" }, {
	group = group,
	callback = refresh,
})

vim.api.nvim_create_autocmd("WinClosed", {
	group = group,
	callback = function(args)
		if state.host_win and tonumber(args.match) == state.host_win then
			state.enabled = false
			state.host_win = nil
			close_face()
		end
	end,
})

vim.keymap.set("n", "<leader>uf", toggle, { desc = "Toggle In-Your-Face", noremap = true, silent = true })
