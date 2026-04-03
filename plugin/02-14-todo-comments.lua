vim.api.nvim_create_autocmd("BufEnter", {
  once = true,
  callback = function()
    vim.pack.add({
      {src="https://github.com/folke/todo-comments.nvim", version="main"},
      {src="https://github.com/nvim-lua/plenary.nvim"}
    })

    require("todo-comments").setup {}
  end,
})

-- Setup keymaps
local wk = require "which-key"
wk.add {
  { "<leader>s", group = "Todo Comments" },
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
}
