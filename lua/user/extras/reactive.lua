local M = {
  "rasulomaroff/reactive.nvim",
}

function M.config()
  require("reactive").setup {
    load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline" },
  }
end

return M
