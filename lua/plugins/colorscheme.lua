local M = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000, -- Load colorscheme early
	opts = {
		flavour = "auto",
		background = { -- :h background
			light = "latte",
			dark = "frappe",
		},
		styles = {
			comments = { "italic" },
			keywords = { "bold", "italic" },
			functions = { "italic" },
			parameters = { "italic" },
			properties = { "italic" },
		},
		custom_highlights = function(colors)
			return {
				LineNrAbove = { fg = colors.flamingo },
				LineNrBelow = { fg = colors.teal },
				NormalFloat = { bg = colors.base, fg = colors.text },
				FloatBorder = { bg = "NONE" },
				TablineFill = { bg = colors.base },
				["@attribute.diff"] = { fg = colors.peach, style = { "underline", "bold" } },
				["@module"] = { fg = colors.sapphire },
				Comment = { fg = colors.overlay2, italic = true },
				["@comment"] = { fg = colors.overlay2, italic = true },
				["@comment.error"] = { fg = colors.red, style = { "bold" } },
				["@comment.warning"] = { fg = colors.yellow, style = { "bold" } },
				["@comment.hint"] = { fg = colors.blue, style = { "bold" } },
				["@comment.todo"] = { fg = colors.flamingo, style = { "bold" } },
				["@comment.note"] = { fg = colors.rosewater, style = { "bold" } },
				NvimWindowFloat = { bg = colors.yellow, fg = colors.base, style = { "bold" } },
				-- Mode Colors
				NormalMode = { fg = colors.sapphire, style = { "bold" } },
				LualineNormalA = { bg = colors.sapphire, fg = colors.text, style = { "bold" } },
				InsertMode = { fg = colors.rosewater, bg = colors.mantle, style = { "bold" } },
				VisualMode = { fg = colors.mauve, style = { "bold" } },
				CommandMode = { fg = colors.peach, style = { "bold" } },
				ReplaceMode = { fg = colors.red, style = { "bold" } },
				SelectMode = { fg = colors.teal, style = { "bold" } },
				TerminalMode = { fg = colors.blue, style = { "bold" } },
				TerminalNormalMode = { fg = colors.sapphire, style = { "bold" } },
			}
		end,
		integrations = {
			beacon = true,
			colorful_winsep = true,
			copilot_vim = true,
			diffview = true,
			flash = true,
			gitsigns = true,
			grug_far = true,
			noice = true,
			notify = true,
			nvim_surround = true,
			mason = true,
			markdown = true,
			neogit = true,
			overseer = true,
			snacks = {
				enabled = true,
				indent_scope_color = "sapphire",
			},
			treesitter_context = true,
			treesitter = true,
			ufo = true,
			which_key = true,
			lualine = {
				all = function(colors)
					return {
						-- Specifying a normal-mode status line override for section a's background and b's foreground to use lavender like the main Catppuccin theme
						normal = {
							a = { bg = colors.sapphire, gui = "italic" },
							b = { fg = colors.sapphire },
						},
						insert = {
							a = { bg = colors.rosewater, gui = "italic" },
							b = { fg = colors.rosewater },
						},
						visual = {
							a = { bg = colors.mauve, gui = "italic" },
							b = { fg = colors.mauve },
						},
						command = {
							a = { bg = colors.peach, gui = "italic" },
							b = { fg = colors.peach },
						},
						replace = {
							a = { bg = colors.red, gui = "italic" },
							b = { fg = colors.red },
						},
						terminal = {
							a = { bg = colors.blue, gui = "italic" },
							b = { fg = colors.blue },
						},
					}
				end,
			},
		},
	},
}

function M.config(_, opts)
	require("catppuccin").setup(opts)
	vim.cmd.colorscheme("catppuccin-nvim")

	-- Clear LSP semantic token comment highlights to let treesitter special comments show through
	-- LSP has priority 125, which overrides treesitter (100), so we clear it entirely
	vim.api.nvim_set_hl(0, "@lsp.type.comment", { link = "" })

	-- Also set high-priority highlights for special comments
	local colors = require("catppuccin.palettes").get_palette("frappe")
	vim.api.nvim_set_hl(0, "@comment.error", { fg = colors.red, bold = true })
	vim.api.nvim_set_hl(0, "@comment.warning", { fg = colors.yellow, bold = true })
	vim.api.nvim_set_hl(0, "@comment.hint", { fg = colors.blue, bold = true })
	vim.api.nvim_set_hl(0, "@comment.todo", { fg = colors.flamingo, bold = true })
	vim.api.nvim_set_hl(0, "@comment.note", { fg = colors.rosewater, bold = true })

	-- Add matchadd patterns for additional comment keywords not covered by treesitter
	-- Skip TODO: and NOTE: as they're already handled by treesitter
	vim.fn.matchadd("@comment.error", "\\(HACK:\\)")
	vim.fn.matchadd("@comment.warning", "\\(WARN:\\)")
	vim.fn.matchadd("@comment.warning", "\\(WARNING:\\)")
	vim.fn.matchadd("@comment.error", "\\(XXX:\\)")
	vim.fn.matchadd("@comment.hint", "\\(PERF:\\)")
	vim.fn.matchadd("@comment.hint", "\\(PERFORMANCE:\\)")
	vim.fn.matchadd("@comment.hint", "\\(OPTIM:\\)")
	vim.fn.matchadd("@comment.hint", "\\(OPTIMIZE:\\)")
	vim.fn.matchadd("@comment.todo", "\\(TEST:\\)")
	vim.fn.matchadd("@comment.todo", "\\(TESTING:\\)")
	vim.fn.matchadd("@comment.note", "\\(PASSED:\\)")
	vim.fn.matchadd("@comment.error", "\\(FAILED:\\)")
end

return M
