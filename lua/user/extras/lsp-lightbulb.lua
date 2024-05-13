local M = {
'kosayoda/nvim-lightbulb',
  event = "VeryLazy"
}

function M.config()
  require("nvim-lightbulb").setup({
    sign = {
      enabled = false,
    },
    virtual_text = {
      enabled = true,
    },
  })
end

return M
