local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "lua",
      "markdown",
      "markdown_inline",
      "bash",
      "python",
      "vue",
      "rust",
      "html",
      "htmldjango",
      "javascript",
      "css",
      "typescript",
      "scss",
      "toml",
      "yaml",
      "comment",
      "dockerfile",
      "gitcommit",
      "gitignore",
      "json",
      "json5",
      "jsonc",
      "regex",
      "sql",
      "ssh_config",
      "tmux",
      "xml",
      "dockerfile",
      "graphql",
    },
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return M
