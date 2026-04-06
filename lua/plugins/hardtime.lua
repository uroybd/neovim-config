local M = {
  "m4xshen/hardtime.nvim",
  event = "VeryLazy",
  opts = {},
}

function M.config(_, opts)
  vim.schedule(function()
    require("hardtime").setup(opts)
  end)
end

return M
