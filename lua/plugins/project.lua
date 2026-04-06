local M = {
  "DrKJeff16/project.nvim",
}

function M.init()
  vim.schedule(function()
    require("project").setup({})
  end)
end

return M
