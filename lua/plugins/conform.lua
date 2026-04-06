local M = {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettierd", "eslint_d", top_after_first = true },
      go = { "goimports-reviser", "gofumpt", "golines" },
      sql = { "sqlfmt" },
      terraform = { "terraform_fmt" },
      rust = { "rustfmt" },
      http = { "kulala-fmt" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  },
}

function M.init()
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

return M
