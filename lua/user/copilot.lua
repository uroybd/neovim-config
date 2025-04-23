local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
}

function M.config()
  require("copilot").setup {
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
  }
end

return M
