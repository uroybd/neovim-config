local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"echasnovski/mini.icons",
	},
}

function M.config()
	local mode_icons = {
		NORMAL = "",
		INSERT = "󰗧",
		VISUAL = "󰒅",
		["V-LINE"] = "󰿚",
		["V-BLOCK"] = "󰾂",
		["O-PENDING"] = "",
		SELECT = "󰲏",
		["S-LINE"] = "󰿚",
		["S-BLOCK"] = "󰾂",
		REPLACE = "",
		["V-REPLACE"] = "",
		TERMINAL = "",
		COMMAND = "",
		EX = "",
		SHELL = "",
		MORE = "",
		CONFIRM = "",
	}

	require("lualine").setup({
		options = {
			-- rounded separators
			component_separators = { left = "", right = "" },
			section_separators = { left = " ", right = " " },
			ignore_focus = { "NvimTree" },
			theme = "kanso",
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
						local icon = mode_icons[str] or ""
						return icon .. " " .. str
					end,
				},
			},
			lualine_b = {
				"branch",
				{
					"diff",
					colored = true,
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
				},
				"diagnostics",
				{ "filename", path = 4 },
			},
			lualine_c = {},
			lualine_x = {
				"selectioncount",
				"searchcount",
			},
			lualine_y = {
				function()
					local clients = vim.lsp.get_clients({ name = "copilot" })
					if #clients == 0 then
						return ""
					end
					return " " -- Simply pull the icon directly from mini.icons
				end,
				"filetype",
			},
			lualine_z = {
				"location",
				"progress",
			},
		},
		extensions = { "quickfix", "man", "fugitive" },
	})

	vim.api.nvim_create_autocmd({ "FocusGained", "UIEnter" }, {
		callback = function()
			vim.cmd("redraw")
			require("lualine").refresh()
		end,
	})
end

return M
