local M = {
  "DrKJeff16/project.nvim",
  event = "VeryLazy",
}
function M.config()
  require("project").setup {}
end
return M
