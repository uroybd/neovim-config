local M = {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  opts = {},
}

function M.config(_, opts)
  vim.schedule(function()
    require("nvim-surround").setup(opts)
  end)
end

return M
