local M = {
  "EthanJWright/vs-tasks.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  event = "VeryLazy",
}

function M.config()
  local wh = require("which-key")
  wh.register({
    ["<leader>rt"] = {
      "<cmd>lua require('telescope').extensions.vstask.tasks()<cr>",
      "Tasks",
    },
    ["<leader>ri"] = {
      "<cmd>lua require('telescope').extensions.vstask.inputs()<cr>", "Task Inputs"
    },
    ["<leader>rh"] = {
      "<cmd>lua require('telescope').extensions.vstask.history()<cr>", "Task History"
    },
    ["<leader>rl"] = {
      "<cmd>lua require('telescope').extensions.vstask.launch()<cr>", "Task Launch"
    }
  })

  require("vstask").setup({})
end 

return M
