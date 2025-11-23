local M = {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  version = "*",
  keys = {
    {
      "<leader>e",
      "<cmd>NvimTreeToggle<CR>",
      desc = "Explorer",
    },
  },
}

function M.config()
  require("nvim-tree").setup {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 35,
      relativenumber = true,
    },
    renderer = {
      group_empty = true,
      root_folder_label = function(fullpath)
        -- Remove `~/Repos` and `/Volumes/Repos` from the root folder label
        -- for example ~/Repos/folder/subfolder becomes folder/subfolder
        -- and /Volumes/Repos/folder/subfolder becomes folder/subfolder
        fullpath = fullpath:gsub(vim.env.HOME .. "/Repos/", "")
        fullpath = fullpath:gsub("/Volumes/Repos/", "")
        -- make the length 25 and prepend with ... if longer
        if #fullpath > 25 then
          fullpath = "..." .. fullpath:sub(-22)
        end
        return fullpath
      end,
      highlight_git = "all",
      highlight_diagnostics = "all",
      highlight_hidden = "all",
      icons = {
        git_placement = "signcolumn",
        diagnostics_placement = "signcolumn",
      },
    },
    filters = {
      dotfiles = true,
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = false, -- Turn into false from true by default
    },
    diagnostics = {
      enable = true,
    },
  }
end

return M
