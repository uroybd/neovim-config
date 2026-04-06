local M = {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    {
      "<leader>gdc",
      "<cmd>CodeDiff main HEAD<cr>",
      desc = "Compare HEAD with main",
    },
    {
      "<leader>gdo",
      "<cmd>CodeDiff main<cr>",
      desc = "Compare with main",
    },
  },
  opts = {
    diff = {
      conflict_result_position = "center",
    },
  },
}

function M.init()
  local wk = require("which-key")
  wk.add({
    { "<leader>gd", group = "Diff" },
  })
end

return M
