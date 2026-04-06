local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
}

function M.config(_, opts)
  vim.defer_fn(function()
    local has_ts, _ = pcall(require, "nvim-treesitter")
    if not has_ts then
      vim.notify("Treesitter not loaded, render-markdown disabled", vim.log.levels.WARN)
      return
    end

    local parsers_ok = pcall(function()
      local parser = vim.treesitter.get_parser(0, "markdown")
      return parser ~= nil
    end)

    if not parsers_ok then
      vim.notify("Markdown parser not ready, render-markdown disabled", vim.log.levels.WARN)
      return
    end

    local ok, render_md = pcall(require, "render-markdown")
    if not ok then
      vim.notify("Failed to load render-markdown plugin", vim.log.levels.ERROR)
      return
    end

    local setup_ok, err = pcall(render_md.setup, opts)
    if not setup_ok then
      vim.notify("render-markdown setup failed: " .. tostring(err), vim.log.levels.ERROR)
    end
  end, 100)
end

return M
