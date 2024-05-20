local M = {
  "3rd/time-tracker.nvim"
}

function M.config()
  require("time-tracker").setup {
    data_file = vim.fn.stdpath("data") .. "/time-tracker.json",
    tracking_events = { "BufEnter", "BufWinEnter", "CursorMoved", "CursorMovedI", "WinScrolled" },
    tracking_timeout_seconds = 1 * 60, -- 1 minute
  }
end

return M
