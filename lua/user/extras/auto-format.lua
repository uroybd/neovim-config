local M = {
  "elentok/format-on-save.nvim"
}

function M.config()
  local format_on_save = require("format-on-save")
  local formatters = require("format-on-save.formatters")
  local vim_notify = require("format-on-save.error-notifiers.vim-notify")

  format_on_save.setup({
    exclude_path_patterns = {
        "/node_modules/",
        ".local/share/nvim/lazy",
    },
    format_by_ft = {
      css = formatters.lsp,
      html = formatters.lsp,
      javascript = formatters.lsp,
      json = formatters.lsp,
      lua = formatters.lsp,
      markdown = formatters.prettierd,
      rust = formatters.lsp,
      vue = formatters.lsp,
      scss = formatters.lsp,
      sh = formatters.shfmt,
      typescript = formatters.prettierd,
      yaml = formatters.lsp,
      python = formatters.lsp
      -- python = {
      --     formatters.remove_trailing_whitespace,
      --     -- formatters.shell({ cmd = "tidy-imports" }),
      --     formatters.black,
      --     formatters.ruff,
      -- }
    },
    error_notifier = vim_notify
  })

end

return M
