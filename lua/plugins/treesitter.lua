local M = {
  "arborist-ts/arborist.nvim",
}

function M.config()
  -- Skip auto-setup since we're configuring manually
  vim.g.arborist_loaded = true
  
  -- Setup arborist - WASM-first treesitter parser manager
  -- Parsers install automatically when you open files!
  require("arborist").setup({
    prefer_wasm = true,        -- Use WASM parsers (faster, no compilation)
    update_cadence = "weekly", -- "daily", "weekly", or "manual"
    compiler = "cc",           -- C compiler for native .so builds (fallback)
  })

  -- Enable treesitter highlighting for all filetypes
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local ft = vim.bo[buf].filetype

      if ft == "oil" then
        return
      end

      -- Disable on large files (>100KB)
      local max_filesize = 100 * 1024
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return
      end

      pcall(vim.treesitter.start)
    end,
  })

  -- Enable treesitter-based folding
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local ft = vim.bo[buf].filetype

      if ft == "oil" then
        return
      end

      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
    end,
  })

  -- Enable treesitter-based indentation (experimental)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*" },
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local ft = vim.bo[buf].filetype

      if ft == "oil" then
        return
      end

      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
