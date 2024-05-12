local M = {
"olrtg/nvim-emmet",
  ft =  { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte", "php", "blade", "twig", "markdown", "yaml", "json", "scss", "less", "stylus", "javascript.jsx", "typescript.tsx"}
}

M.config = function()
 local wk = require("which-key")
 wk.register{
  ["<leader>xe"] = { "<cmd>require('nvim-emmet').wrap_with_abbreviation<cr>", "Emmet Wrap with Abbreviation"}
} 
end

return M
