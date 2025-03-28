local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

function M.config()
  local servers = {
    "bashls",
    "cssls",
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
    "volar",
    "yamlls",
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }
end

return M
