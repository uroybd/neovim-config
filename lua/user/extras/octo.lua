local M = {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  require("octo").setup {
    picker = "fzf-lua",
  }
end

return M
