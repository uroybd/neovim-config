local M = {
  "stevearc/overseer.nvim",
  event = "VeryLazy",
  opts = {},
}

function M.config(_, opts)
  require("overseer").setup(opts)

  local wk = require("which-key")
  wk.add({
    { "<leader>T", group = "Tasks" },
    { "<leader>Tt", "<cmd>OverseerToggle<CR>", desc = "Toggle" },
    { "<leader>Tr", "<cmd>OverseerRun<CR>", desc = "Run" },
  })
end

return M
