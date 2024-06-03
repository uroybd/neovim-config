local M = {
  "tris203/precognition.nvim",
  event = "VeryLazy",
}

function M.config()
  require("precognition").setup {}
end

return M
