local M = {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
}

function M.config()
  require("fzf-lua").setup {
    buffers = {
      winopts = {
        preview = { hidden = "hidden" },
        height = 0.6,
        width = 0.4,
        row = 0.5,
        col = 0.5,
      },
    },
    files = {
      cwd_prompt = false,
      prompt = "Files❯ ",
      winopts = {
        preview = { hidden = "hidden" },
        height = 0.6,
        width = 0.4,
        row = 0.5,
        col = 0.5,
      },
    },
    winopts = {
      height = 0.6,
      width = 0.8,
      treesitter = {
        enable = true,
      },
      backdrop = 100,
    },
  }

  local wk = require "which-key"
  wk.add {
    {
      "<leader>bb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Buffers",
      icon = "",
    },
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "Find files",
      icon = "󰈞",
    },
    {
      "<leader>fl",
      function()
        require("fzf-lua").resume()
      end,
      desc = "Last Search",
      icon = "󱘞",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "Recent File",
      icon = "",
    },
    {
      "<leader>ft",
      function()
        require("fzf-lua").live_grep_native()
      end,
      desc = "Find Text",
      icon = "󰺮",
    },
    {
      "<leader>fs",
      function()
        require("fzf-lua").lsp_live_workspace_symbols()
      end,
      desc = "Find Symbol",
      icon = "",
    },
    {
      "<leader>gC",
      function()
        require("fzf-lua").git_branches()
      end,
      desc = "Checkout branch",
      icon = "󱓏",
    },
    {
      "<leader>fh",
      function()
        require("fzf-lua").helptags()
      end,
      desc = "Help",
      icon = "󰞋",
    },
  }
end

return M
