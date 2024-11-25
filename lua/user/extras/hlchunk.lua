local M = {
  "shellRaining/hlchunk.nvim",
  branch = "main",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  require("hlchunk").setup {
    indent = {
      enable = true,
    },
    chunk = {
      enable = true,
    },
  }
end

return M
