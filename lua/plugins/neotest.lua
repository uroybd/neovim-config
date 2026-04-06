local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "mrcjkb/rustaceanvim",
    "rouge8/neotest-rust",
  },
  keys = {
    { "<leader>rn", "<cmd>lua require('neotest').run.run()<CR>", desc = "Run Nearest Test" },
    { "<leader>rN", "<cmd>lua require('neotest').run.run_last()<CR>", desc = "Run Last Test" },
    { "<leader>rS", "<cmd>lua require('neotest').run.stop()<CR>", desc = "Stop Test" },
    { "<leader>ra", "<cmd>lua require('neotest').run.attach()<CR>", desc = "Attach to Test" },
    {
      "<leader>rf",
      "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
      desc = "Run File Tests",
    },
    { "<leader>ro", "<cmd>Neotest output-panel<CR>", desc = "Open Output Panel" },
    { "<leader>rs", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "Toggle Test Summary" },
  },
  opts = {
    adapters = {
      ["neotest-rust"] = {},
    },
  },
}

function M.config(_, opts)
  vim.schedule(function()
    local adapters = {}
    for name, config in pairs(opts.adapters or {}) do
      if type(name) == "number" then
        table.insert(adapters, config)
      else
        local ok, adapter = pcall(require, name)
        if ok then
          table.insert(adapters, adapter(config))
        end
      end
    end
    opts.adapters = adapters

    require("neotest").setup(opts)
  end)
end

return M
