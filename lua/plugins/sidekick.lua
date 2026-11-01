local M = {
	"folke/sidekick.nvim",
	event = "VeryLazy",
}

function M.config(_, _)
	require("sidekick").setup({
		nes = {
			enabled = true,
		},
		cli = {
			tools = {
				claude_fulflld = {
					cmd = { "claude" }, -- Invokes the same underlying binary
					is_proc = "\\<claude\\>", -- Process matching rules for sidekick's tracker
					env = {
						CLAUDE_CONFIG_DIR = vim.fn.expand("~/.claude-fulflld"), -- Isolate its data here!
					},
				},
			},
			win = {
				float = {
					width = 0.4, -- Takes up 40% of the screen width
					height = 0.8, -- Takes up 80% of the screen height
					row = 2, -- Centers or offsets it nicely
					col = vim.o.columns, -- Aligns towards the right side of the screen
				},
			},
			mux = {
				backend = "zellij",
				enabled = true,
			},
		},
	})

	vim.keymap.set("n", "<tab>", function()
		if not require("sidekick").nes_jump_or_apply() then
			return "<Tab>"
		end
	end, { expr = true, desc = "Goto/Apply Next Edit Suggestion" })

	local wk = require("which-key")
	wk.add({
		{
			"<leader>aa",
			function()
				require("sidekick.cli").toggle({ name = "claude_fulflld", focus = true })
			end,
			desc = "Sidekick Toggle Claude [FULFLLD]",
		},
		{
			"<leader>ac",
			function()
				require("sidekick.cli").toggle({ name = "claude", focus = true })
			end,
			desc = "Sidekick Toggle Claude",
		},
		{
			"<c-.>",
			function()
				require("sidekick.cli").toggle()
			end,
			desc = "Sidekick Toggle",
			mode = { "n", "t", "i", "x" },
		},
		{
			"<leader>as",
			function()
				require("sidekick.cli").select({ filter = { installed = true } })
			end,
			desc = "Select CLI",
		},
		{
			"<leader>ad",
			function()
				require("sidekick.cli").close()
			end,
			desc = "Detach a CLI Session",
		},
		{
			"<leader>at",
			function()
				require("sidekick.cli").send({ msg = "{this}" })
			end,
			mode = { "x", "n" },
			desc = "Send This",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "{file}" })
			end,
			desc = "Send File",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}" })
			end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
	})
end

return M
