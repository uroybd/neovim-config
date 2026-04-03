vim.schedule(function()
  vim.pack.add({
    {src="https://github.com/nvim-treesitter/nvim-treesitter", version="master"},
    {src="https://github.com/nvim-neotest/neotest"},
    {src="https://github.com/nvim-neotest/nvim-nio"},
    {src="https://github.com/nvim-lua/plenary.nvim"},
    {src="https://github.com/antoinemadec/FixCursorHold.nvim"},
    {src="https://github.com/mrcjkb/rustaceanvim"},
    {src="https://github.com/fredrikaverpil/neotest-golang"},
    {src="https://github.com/rouge8/neotest-rust"}
  })

  require("neotest").setup {
    adapters = {
      require "neotest-golang" {},
      require("neotest-rust"),
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
end)
