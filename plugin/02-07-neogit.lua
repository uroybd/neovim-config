-- Load on keybind or command
vim.api.nvim_create_autocmd("User", {
  pattern = "NeogitLoad",
  once = true,
  callback = function()
    vim.pack.add({
      {src="https://github.com/neogitorg/neogit", version="master"},
      {src="https://github.com/nvim-lua/plenary.nvim"},
      {src="https://github.com/esmuellert/codediff.nvim"}
    })

    local icons = require "user.icons"
    
    require("neogit").setup {
      auto_refresh = true,
      disable_builtin_notifications = false,
      use_magit_keybindings = false,
      graph_style = "kitty",
      integrations = {
        codediff = true,
        snacks = true,
      },
      diff_viewer = "codediff",
      kind = "tab",
      commit_popup = {
        kind = "split",
      },
      popup = {
        kind = "split",
      },
      signs = {
        section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
        item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
        hunk = { "", "" },
      },
    }
    
    -- Open neogit if triggered by command
    if vim.v.vim_did_enter == 1 then
      vim.cmd("Neogit")
    end
  end,
})

-- Setup keybindings and command to trigger loading
local wk = require "which-key"
wk.add {
  { 
    "<leader>gg", 
    function()
      vim.api.nvim_exec_autocmds("User", { pattern = "NeogitLoad" })
    end, 
    desc = "Neogit", 
    icon = "󰊢" 
  },
}

vim.api.nvim_create_user_command("Neogit", function()
  vim.api.nvim_exec_autocmds("User", { pattern = "NeogitLoad" })
end, {})
