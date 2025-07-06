local M = {
  "folke/which-key.nvim",
}

function M.config()
  local which_key = require "which-key"
  which_key.setup {
    preset = "helix",
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    -- window = {
    --   border = "rounded",
    --   position = "bottom",
    --   padding = { 2, 2, 2, 2 },
    -- },
    ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
    layout = {
      align = "center",
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  local mappings = {
    { "<leader>t", group = "Tab" },
    { "<leader>tN", "<cmd>tabnew %<cr>", desc = "New Tab" },
    { "<leader>th", "<cmd>-tabnext<cr>", desc = "Prev Tab" },
    { "<leader>tl", "<cmd>+tabnext<cr>", desc = "Next Tab" },
    { "<leader>tn", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
    { "<leader>tc", "<cmd>tabclose<cr>", desc = "Close Tab" },
    { "<leader>to", "<cmd>tabonly<cr>", desc = "Only" },
    { "<leader>tm", group = "Tab Move" },
    { "<leader>tmh", "<cmd>-tabmove<cr>", desc = "Move Left" },
    { "<leader>tml", "<cmd>+tabmove<cr>", desc = "Move Right" },
    { "<leader>b", group = "Buffers" },
    { "<leader>c", group = "Multiple Cursors" },
    { "<leader>d", group = "Debug" },
    { "<leader>D", group = "Docs" },
    { "<leader>Dc", group = "Apidocs for current filetype" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>gc", group = "Conflict", icon = "" },
    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL", icon = "󰷙" },
    { "<leader>l", group = "LSP", icon = "" },
    { "<leader>p", group = "Plugins" },
    { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
    { "<leader>r", group = "Run", icon = "󱤵" },
    { "<leader>s", group = "Todo Comments" },
    { "<leader>t", group = "Test", icon = "" },
    { "<leader>v", "<cmd>vsplit<CR>", desc = "Split", icon = "" },
    { "<leader>w", "<cmd>lua vim.wo.wrap = not vim.wo.wrap<CR>", desc = "Toggle Wrap" },
    { "<leader>n", group = "Swap parameters" },
  }

  which_key.add(mappings, opts)
end

return M
