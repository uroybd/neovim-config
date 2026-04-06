local M = {
  "mrcjkb/rustaceanvim",
  sem_version = "^6", -- zpack's lazy.nvim compat for version
  ft = "rust", -- Lazy load on Rust files
  -- rustaceanvim automatically sets up rust-analyzer and other Rust tooling
  -- Configuration can be done via vim.g.rustaceanvim if needed
}

function M.init()
  -- Any pre-load configuration can go here
  -- vim.g.rustaceanvim = { ... }
end

return M
