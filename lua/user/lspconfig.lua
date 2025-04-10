local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    { { "folke/lazydev.nvim", ft = "lua" }, "nvimdev/lspsaga.nvim" },
  },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  return capabilities
end

M.toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
end

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
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
  }
  local lspconfig = require "lspconfig"
  local icons = require "user.icons"

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

  local default_diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(default_diagnostic_config)

  require("lspconfig.ui.windows").default_options.border = "rounded"

  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = require("blink.cmp").get_lsp_capabilities(M.common_capabilities()),
      inlay_hints = { enabled = true },
    }

    local require_ok, settings = pcall(require, "user.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    if server == "lua_ls" then
      require("lazydev").setup {}
    end

    lspconfig[server].setup(opts)
  end

  require("lspsaga").setup {
    ui = {
      kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
      devicon = true,
      code_action = "",
    },
    breadcrumbs = {
      hide_keyword = true,
    },
    diagnostic = {
      jump_num_shortcut = true,
      diagnostic_only_current = true,
    },
    code_action = {
      num_shortcut = true,
      extend_gitsigns = true,
    },
  }

  vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
  vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
  vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
  wk.add {
    { "<leader>dd", "<cmd>Lspsaga show_buf_diagnostics ++normal<cr>", desc = "Document Diagonostics", icon = "󱪗" },
    {
      "<leader>dw",
      "<cmd>Lspsaga show_workspace_diagnostics ++normal<cr>",
      desc = "Workspace Diagonostics",
      icon = "󰷌",
    },
    { "<leader>lc", group = "Call Hierarchy" },
    { "<leader>lci", "<cmd>Lspsaga incoming_calls<cr>", desc = "Incoming Calls" },
    { "<leader>lco", "<cmd>Lspsaga outgoing_calls<cr>", desc = "Outgoing Calls" },
    { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Finder" },
    { "<leader>ll", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
    { "<leader>lo", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
    { "<leader>lp", group = "Peek" },
    { "<leader>lpd", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek Definition" },
    { "<leader>lpt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek Type" },
    { "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "Rename Symbol" },
  }
end

return M
