-- Setup lazy loading
local function load_nvim_tree()
  vim.pack.add({
    {src="https://github.com/nvim-tree/nvim-tree.lua", version="*"}
  })

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
      always_show_folders = false,
    },
    diagnostics = {
      enable = true,
    },
  }
end

-- Setup keymaps
local wk = require "which-key"
wk.add {
  {
    "<leader>e",
    function()
      load_nvim_tree()
      vim.cmd("NvimTreeToggle")
    end,
    desc = "Explorer",
  },
}

-- Create commands
vim.api.nvim_create_user_command("NvimTreeToggle", function()
  load_nvim_tree()
  vim.cmd("NvimTreeToggle")
end, {})

vim.api.nvim_create_user_command("NvimTreeFocus", function()
  load_nvim_tree()
  vim.cmd("NvimTreeFocus")
end, {})
