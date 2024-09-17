local M = {
  "nanozuki/tabby.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  require("tabby").setup {}
  local wk = require "which-key"
  wk.add {
    { "<leader>aj", "<cmd>Tabby jump_to_tab<cr>", desc = "Jump to tab" },
    {
      "<leader>ar",
      function()
        local tab_name = vim.fn.input("Tab name", "")
        if tab_name then
          require("tabby").tab_rename(tab_name)
        end
      end,
      desc = "Rename tab",
    },
  }
end

return M
