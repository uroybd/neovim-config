local M = {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    {
      "<leader>dw",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>dd",
      "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>lo",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Outline",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
  opts = {},
}

return M
