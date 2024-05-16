local M = {
  "rcarriga/nvim-notify",
  event = "VeryLazy"
}

function M.config()
  vim.notify = require("notify")
  vim.notify.setup({
    stages = "fade_in_slide_out",
    timeout = 3000,
    render = "wrapped-compact"
  })
end

return M
