local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

keymap("n", "<C-i>", "<C-i>", opts)

-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)
keymap("n", "<m-tab>", "<c-6>", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("x", "p", [["_dP]])

vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]])

keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
keymap("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- more good
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- tailwind bearable to work with
keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)

-- Comment keybindings
-- Helper function to insert comment at position
local function insert_comment(position)
	local commentstring = vim.bo.commentstring
	local comment_start = commentstring:match("^(.*)%%s")
	if comment_start then
		vim.cmd("normal! " .. position .. comment_start .. " ")
		vim.cmd("startinsert!")
	end
end

-- Insert a comment in the line below
keymap("n", "gco", function()
	insert_comment("o")
end, opts)
-- Insert a comment in the line above
keymap("n", "gcO", function()
	insert_comment("O")
end, opts)
-- Append a comment at the end of the line
keymap("n", "gcA", function()
	insert_comment("A ")
end, opts)

-- If the current line contains an mark with [a-zA-Z], delete all marks in the current line
local function del_marks_in_current_line()
	local current_buf = vim.api.nvim_get_current_buf()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local marks = vim.fn.getmarklist()
	for _, mark in ipairs(marks) do
		if mark.pos[1] == current_buf and mark.pos[2] == current_line and mark.mark:match("[A-Z]") then
			vim.api.nvim_del_mark(string.sub(mark.mark, 2, 2))
		end
	end
	local local_marks = vim.fn.getmarklist(current_buf)
	for _, mark in ipairs(local_marks) do
		if mark.pos[2] == current_line and mark.mark:match("[a-z]") then
			vim.api.nvim_buf_del_mark(current_buf, string.sub(mark.mark, 2, 2))
		end
	end
end

keymap("n", "dm", del_marks_in_current_line, opts)
