local M = {
  "m4xshen/hardtime.nvim",
  lazy = false,
}

function M.config()
  require("hardtime").setup {}
end

return M
