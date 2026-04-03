vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.pack.add({
      {src="https://github.com/williamboman/mason.nvim"},
      {src="https://github.com/williamboman/mason-lspconfig.nvim"}
    })

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

    -- Formatters and linters that mason can install
    local tools = {
      -- Lua
      "stylua",
      -- Python
      "isort",
      "black",
      -- JavaScript/TypeScript
      "prettierd",
      "eslint_d",
      -- Go
      "goimports-reviser",
      "gofumpt",
      "golines",
      -- SQL
      "sqlfmt",
    }

    require("mason").setup {
      ui = {
        border = "rounded",
      },
    }

    require("mason-lspconfig").setup {
      ensure_installed = servers,
    }

    -- Install formatters/linters after registry is ready
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
  end,
})
