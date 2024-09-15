local M = {
  "monkoose/neocodeium",
  event = "VeryLazy"
} 


function M.config()
  require('neocodeium').setup({
    filetypes =  {
        TelescopePrompt = false,
        ["dap-repl"] = false,
    },
  })
  
  vim.keymap.set("i", "<c-l>", function() require('neocodeium').accept() end)
  vim.keymap.set("i", "<c-j>", function() require("neocodeium").cycle_or_complete()end)
  vim.keymap.set("i", "<c-k>", function() require("neocodeium").cycle_or_complete(-1) end)
  vim.keymap.set("i", "<c-h>", function() require("neocodeium").clear() end)
end

return M
