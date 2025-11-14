local M = {
  "neovim/nvim-lspconfig",
  branch = "master",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { { "folke/lazydev.nvim", ft = "lua" }, },
  },
}

function M.config()
  local wk = require "which-key"
  wk.add {
    {
      "<leader>lf",
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      desc = "Format",
    },
    { "<leader>lh", "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
  }

  local servers = {
    "bashls",
    "cssls",
    "copilot",
    "docker_compose_language_service",
    "dockerls",
    "eslint",
    "gopls",
    "graphql",
    "harper_ls",
    "html",
    "jsonls",
    "lua_ls",
    "nginx_language_server",
    "nushell",
    "prismals",
    "pyright",
    "rust_analyzer",
    "sqls",
    "svelte",
    "terraformls",
    "ts_ls",
    "yamlls",
  }

  vim.lsp.enable(servers, true)

  for _, server in pairs(servers) do
    local require_ok, settings = pcall(require, "user.lspsettings." .. server)
    if require_ok then
      vim.lsp.config(server, settings)
    end

    if server == "lua_ls" then
      require("lazydev").setup {}
    end
  end

  local signs = {
    [vim.diagnostic.severity.ERROR] = "󰅙",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.INFO] = "",
    [vim.diagnostic.severity.HINT] = "󰌵",
  }

  vim.diagnostic.config {

    signs = {
      text = signs,
    },
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return M
