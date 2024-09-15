local M = {
    "rcarriga/nvim-notify"
}

function M.config()
  require("notify").setup({
     render = "wrapped-compact",
    stages = "static",
  });
end

return M
