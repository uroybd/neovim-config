local M = {
	"OXY2DEV/markview.nvim",
	lazy = false,
}

function M.config()
	require("markview").setup({
		preview = {
			icon_provider = "mini",
			-- ghlite renders its PR/commit/comment views into `nofile` markdown
			-- buffers, which markview skips by default (preview.ignore_buftypes
			-- = { "nofile" }). Opt those buffers back in: they all carry a
			-- ` (YYYY-MM-DD HH:MM:SS)` timestamp suffix in their name.
			condition = function(buf)
				local name = vim.api.nvim_buf_get_name(buf)
				if name:match("%(%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d%)$") then
					return true
				end
				-- return nil -> fall through to markview's default checks
			end,
		},
	})
end

return M
