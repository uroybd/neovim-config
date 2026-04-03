vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "codecompanion" },
  once = true,
  callback = function()
    -- Add slight delay to ensure treesitter is ready
    vim.defer_fn(function()
      -- Ensure treesitter is loaded
      local has_ts, _ = pcall(require, "nvim-treesitter")
      if not has_ts then
        vim.notify("Treesitter not loaded, render-markdown disabled", vim.log.levels.WARN)
        return
      end
      
      -- Check if markdown parsers are installed and working
      local parsers_ok = pcall(function()
        local parser = vim.treesitter.get_parser(0, "markdown")
        return parser ~= nil
      end)
      
      if not parsers_ok then
        vim.notify("Markdown parser not ready, render-markdown disabled", vim.log.levels.WARN)
        return
      end
      
      -- Load render-markdown plugin
      vim.pack.add({
        {src="https://github.com/MeanderingProgrammer/render-markdown.nvim"}
      })
      
      -- Setup with error handling
      local ok, render_md = pcall(require, "render-markdown")
      if not ok then
        vim.notify("Failed to load render-markdown plugin", vim.log.levels.ERROR)
        return
      end
      
      local setup_ok, err = pcall(render_md.setup, {})
      if not setup_ok then
        vim.notify("render-markdown setup failed: " .. tostring(err), vim.log.levels.ERROR)
      end
    end, 100)
  end,
})
