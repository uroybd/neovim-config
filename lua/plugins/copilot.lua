local M = {
  "zbirenbaum/copilot.lua",
  event = "VeryLazy",
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<c-l>",
        accept_word = false,
        accept_line = false,
        next = "<c-j>",
        prev = "<c-k>",
        dismiss = "<C-h>",
      },
    },
    filetypes = {
      snacks_picker_input = false,
    },
  },
}

function M.config(_, opts)
  vim.schedule(function()
    require("copilot").setup(opts)
  end)
end

return M
