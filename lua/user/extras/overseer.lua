local M = {
  "stevearc/overseer.nvim",
  -- lazy = true,
}

function M.config()
  require("overseer").setup {
  }
  local wk = require "which-key"
  wk.add {
    { "<leader>T", group = "Tasks" },
    { "<leader>Tt", "<cmd>OverseerToggle<CR>", desc = "Toggle" },
    { "<leader>Tr", "<cmd>OverseerRun<CR>", desc = "Run" },
  }
end

return M
