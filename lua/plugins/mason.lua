return {
  (function()
    local M = {
      "williamboman/mason.nvim",
      dependencies = { "williamboman/mason-lspconfig.nvim" },
      event = "VimEnter",
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
        "prismals",
        "pyright",
        "rust_analyzer",
        "sqls",
        "svelte",
        "terraformls",
        "ts_ls",
        "yamlls",
      }

      local tools = {
        "stylua",
        "isort",
        "black",
        "prettierd",
        "eslint_d",
        "goimports-reviser",
        "gofumpt",
        "golines",
        "sqlfmt",
      }

      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      local registry = require("mason-registry")

      local function ensure_installed()
        for _, tool in ipairs(tools) do
          local ok, p = pcall(registry.get_package, tool)
          if ok and p and not p:is_installed() then
            p:install()
          end
        end
      end

      if registry.refresh then
        registry.refresh(vim.schedule_wrap(ensure_installed))
      else
        ensure_installed()
      end
    end

    return M
  end)(),
  {
    "williamboman/mason-lspconfig.nvim",
  },
}
