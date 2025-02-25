local M = {
  "folke/todo-comments.nvim",
  branch = "main",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  keys = {
    {
      "<leader>st",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "Todo",
    },
    {
      "<leader>sT",
      function()
        Snacks.picker.todo_comments { keywords = { "TODO", "FIX", "FIXME" } }
      end,
      desc = "Todo/Fix/Fixme",
    },
  },
}

function M.config()
  require("todo-comments").setup {}
end

return M
