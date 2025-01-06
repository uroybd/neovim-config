local M = {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  local detail = false
  require("oil").setup {
    float = {
      max_height = 20,
      max_width = 100,
    },
    delete_to_trash = true,
    keymaps = {
      ["gd"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail = not detail
          if detail then
            require("oil").set_columns { "icon", "permissions", "size", "mtime" }
          else
            require("oil").set_columns { "icon" }
          end
        end,
      },
    },
  }
  vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
end

return M
