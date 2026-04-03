vim.pack.add({
  {src="https://github.com/nvim-treesitter/nvim-treesitter", version="master"}
})

vim.schedule(function()
  local ts_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
  
  if not ts_ok then
    vim.notify("nvim-treesitter not found", vim.log.levels.ERROR)
    return
  end
  
  ts_configs.setup {
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
    
    -- Auto-install missing parsers when entering buffer
    auto_install = true,
    
    highlight = { 
      enable = true,
      -- Disable function for specific conditions
      disable = function(lang, buf)
        -- Disable for oil filetype
        if vim.bo[buf].filetype == "oil" then
          return true
        end
        
        -- Disable on large files (>100KB)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
        
        return false
      end,
      additional_vim_regex_highlighting = false,
    },
    
    indent = { 
      enable = true,
      -- Disable indent for languages where it's problematic
      disable = { "python" },
    },
  }
end)
