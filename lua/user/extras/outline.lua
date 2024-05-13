local M = {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
}

function M.config()
  local wh = require("which-key")
  wh.register{
    ["<leader>lo"] = {
     "<cmd>Outline<cr>", "Outline"
    },
  }
 
  require("outline").setup({})
end

return M
