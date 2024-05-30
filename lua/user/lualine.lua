local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
}

function M.config()
  require("lualine").setup {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = " ", right = " " },
      
      ignore_focus = { "NvimTree" },
      theme = "catppuccin"
    },
    sections = {
      lualine_a = {"mode"},
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { {"filename", path = 4} },
      lualine_x = { "copilot", "filetype" },
      lualine_y = { "searchcount" },
      lualine_z = { "selectioncount", "location", "progress" },
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M
