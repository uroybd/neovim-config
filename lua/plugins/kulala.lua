local M = {
  "mistweaverco/kulala.nvim",
  event = "VeryLazy",
  opts = {
    winbar = true,
    default_winbar_panes = { "body", "headers", "headers_body", "script_output" },
    split_direction = "vertical",
  },
}

function M.config(_, opts)
  require("kulala").setup(opts)

  vim.filetype.add({
    extension = {
      http = "http",
    },
  })

  local wk = require("which-key")
  local kl = require("kulala")

  wk.add({
    { "<leader>k", group = "Kulala" },
    { "<leader>ka", kl.run_all, desc = "Run All" },
    { "<leader>ks", kl.search, desc = "Search" },
    { "<leader>kS", kl.show_stats, desc = "Statistics" },
    { "<leader>kc", kl.close, desc = "Close" },
    { "<leader>kG", kl.download_graphql_schema, desc = "Download GraphQL Schema" },
    { "<leader>ke", kl.set_selected_env, desc = "Select Environment" },
  })
end

return M
