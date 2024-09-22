local M = {
  "stevearc/conform.nvim",
}

function M.config()
  require("conform").setup {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
      go = { "goimports", "gofmt" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  }
end
function M.init()
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

return M
