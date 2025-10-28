local M = {
  "neovim/nvim-lspconfig",
  branch = "master",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { { "folke/lazydev.nvim", ft = "lua" }, "nvimdev/lspsaga.nvim" },
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
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
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

  require("lspsaga").setup {
    ui = {
      kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
      devicon = true,
      code_action = "",
    },
    symbol_in_winbar = {
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
