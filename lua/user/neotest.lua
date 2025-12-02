local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "mrcjkb/rustaceanvim",
    "nvim-treesitter/nvim-treesitter",
    { "fredrikaverpil/neotest-golang", version = "*" },
  },
}

function M.config()
  require("neotest").setup {
    adapters = {
      require "neotest-golang" {}, -- Registration
      require('rustaceanvim.neotest'),
    },
  }
  local wk = require "which-key"
  wk.add {
    { "<leader>rn", "<cmd>lua require('neotest').run.run()<CR>", desc = "Run Nearest Test" },
    { "<leader>rN", "<cmd>lua require('neotest').run.run_last()<CR>", desc = "Run Last Test" },
    { "<leader>rS", "<cmd>lua require('neotest').run.stop()<CR>", desc = "Stop Test" },
    { "<leader>ra", "<cmd>lua require('neotest').run.attach()<CR>", desc = "Attach to Test" },
    { "<leader>rf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run File Tests" },
    { "<leader>ro", "<cmd>Neotest output-panel<CR>", desc = "Open Output Panel" },
    { "<leader>rs", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "Toggle Test Summary" },
  }
end

return M
