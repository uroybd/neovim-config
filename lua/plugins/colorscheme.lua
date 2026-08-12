local M = {
	"webhooked/kanso.nvim",
	lazy = false,
	priority = 1000,
}

-- Keyword table mirrors folke/todo-comments.nvim's default `keywords` config:
-- https://github.com/folke/todo-comments.nvim#-configuration
-- `hl` is the highlight group (colors set in kanso's `overrides`, below).
local todo_keywords = {
	FIX = { hl = "TodoCommentsFix", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
	TODO = { hl = "TodoCommentsTodo" },
	HACK = { hl = "TodoCommentsHack" },
	WARN = { hl = "TodoCommentsWarn", alt = { "WARNING", "XXX" } },
	PERF = { hl = "TodoCommentsPerf", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
	NOTE = { hl = "TodoCommentsNote", alt = { "INFO" } },
	TEST = { hl = "TodoCommentsTest", alt = { "TESTING", "PASSED", "FAILED" } },
}

local function registerTODOCommentPatterns()
	local todo_group = vim.api.nvim_create_augroup("NativeTodoGroup", { clear = true })

	vim.api.nvim_create_autocmd({ "Syntax", "FileType" }, {
		group = todo_group,
		pattern = "*",
		callback = function()
			for keyword, opts in pairs(todo_keywords) do
				local words = { keyword }
				if opts.alt then
					vim.list_extend(words, opts.alt)
				end
				-- Mirrors todo-comments.nvim's default highlight pattern: keyword immediately
				-- followed by a colon, e.g. "TODO:" / "FIXME:".
				vim.fn.matchadd(opts.hl, [[\v\C<(]] .. table.concat(words, "|") .. [[):]])
			end
		end,
	})
end

function M.config()
	require("kanso").setup({
		compile = true,
		background = {
			dark = "mist",
			light = "pearl",
		},
		keywordStyle = { italic = true, bold = true },
		dimInactive = true,
		overrides = function(colors)
			-- Filled background in the keyword's color with bold text, falling back to
			-- linking a known Diagnostic* group when the palette color isn't available.
			local function badge(color, fallback)
				if color then
					return { bg = color, fg = colors.theme.ui.bg, bold = true }
				end
				return { link = fallback, bold = true }
			end

			return {
				LineNrAbove = { fg = colors.palette.green2 },
				LineNrBelow = { fg = colors.palette.blue2 },
				["@module"] = { fg = colors.palette.yellow },

				TodoCommentsFix = badge(colors.palette.red, "DiagnosticError"),
				TodoCommentsTodo = badge(colors.palette.blue, "DiagnosticInfo"),
				TodoCommentsHack = badge(colors.palette.orange, "DiagnosticWarn"),
				TodoCommentsWarn = badge(colors.palette.yellow, "DiagnosticWarn"),
				TodoCommentsPerf = badge(colors.palette.aqua, "DiagnosticHint"),
				TodoCommentsNote = badge(colors.palette.green, "DiagnosticHint"),
				TodoCommentsTest = badge(colors.palette.violet, "DiagnosticOk"),
			}
		end,
	})
	vim.cmd.colorscheme("kanso")
	registerTODOCommentPatterns()
end

return M
