local M = {
"nvim-zh/colorful-winsep.nvim",
  event = { "WinLeave" }
}

function M.config()
require("colorful-winsep").setup({
    -- hi = {
    --   fg = "#7287fd"
    -- }
  })
end

return M
