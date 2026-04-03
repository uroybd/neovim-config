vim.api.nvim_create_autocmd({
  "BufReadPost",
  "BufNewFile",
},{
  once = true,
  callback = function()
    vim.pack.add({
        {src="https://github.com/nvim-treesitter/nvim-treesitter", version="master"}
      })
require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "bash",
      "comment",
      "css",
      "diff",
      "dockerfile",
      "gitcommit",
      "gitignore",
      "git_config",
      "git_rebase",
      "go",
      "graphql",
      "html",
      "htmldjango",
      "http",
      "javascript",
      "json",
      "json5",
      "jsonc",
      "kdl",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "nginx",
      "nu",
      "prisma",
      "python",
      "regex",
      "rust",
      "scss",
      "sql",
      "ssh_config",
      "svelte",
      "terraform",
      "toml",
      "typescript",
      "tsx",
      "vue",
      "xml",
      "yaml",
    },
    highlight = { enable = true, disable = { "oil" } },
    indent = { enable = true },
  }
  end
})
