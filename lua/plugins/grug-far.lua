local M = {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>fg",
      "<cmd>GrugFar<cr>",
      desc = "Replace",
    },
  },
  opts = {
    windowCreationCommand = "tab split",
  },
}

return M
