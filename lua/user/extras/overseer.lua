local M = {
  "stevearc/overseer.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim", "stevearc/dressing.nvim" },
}

function M.config()
  require("overseer").setup {
    templates = { "builtin", "user.cz_bump", "user.cz_bump_server" },
  }
  local wk = require "which-key"
  wk.add {
    { "<leader>Tt", "<cmd>OverseerToggle<CR>", desc = "Toggle" },
    { "<leader>Tr", "<cmd>OverseerRun<CR>", desc = "Run" },
  }
end

return M
