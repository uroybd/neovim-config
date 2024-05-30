local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/neodev.nvim",
      "nvimdev/lspsaga.nvim"
    },
  },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
  end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

M.toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(bufnr), { bufnr = bufnr })
end

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>lf"] = {
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      "Format",
    },
    ["<leader>li"] = { "<cmd>LspInfo<cr>", "Info" },
    ["<leader>lh"] = { "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
    ["<leader>lq"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
  }


  local lspconfig = require "lspconfig"
  local icons = require "user.icons"

  local servers = {
    "lua_ls",
    "cssls",
    "html",
    "tsserver",
    "eslint",
    "tsserver",
    "pyright",
    -- "ruff_lsp",
    "bashls",
    "jsonls",
    "yamlls",
    "volar",
    "nushell"
  }

  local default_diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
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

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    local require_ok, settings = pcall(require, "user.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    if server == "lua_ls" then
      require("neodev").setup {}
    end

    lspconfig[server].setup(opts)


  require("lspsaga").setup({
    ui = {
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    },
    diagonostic = {
      jump_num_shortcut = true
    },
    code_action = {
      extend_gitsigns = true
    }
  })
  wk.register({
    ["<leader>lc"] = {
      name = "Call Hierarchy",
      i = { "<cmd>Lspsaga incoming_calls<cr>", "Incoming Calls" },
      o = { "<cmd>Lspsaga outgoing_calls<cr>", "Outgoing Calls" },
    },
    ["<leader>lp"] = {
      name = "Peek",
      d = { "<cmd>Lspsaga peek_definition<cr>", "Peek Definition" },
      t = { "<cmd>Lspsaga peek_type_definition<cr>", "Peek Type" },
    },
    ["<leader>ll"] = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
    ["<leader>lo"] = {"<cmd>Lspsaga outline<cr>", "Outline"},
    ["<leader>lf"] = {"<cmd>Lspsaga finder<cr>", "Finder"},
    ["<leader>lr"] = {"<cmd>Lspsaga rename<cr>", "Rename Symbol"},
    -- ["<leader>;"] = {"<cmd>Lspsaga term_toggle<cr>", "Terminal"}
  })

  vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_next<CR>')
  vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
  vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>')
  vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
  end
end

return M
