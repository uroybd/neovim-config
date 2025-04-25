local M = {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  },
  build = "make tiktoken", -- Only on MacOS or Linux
  cmd = {
    "CopilotChat",
    "CopilotChatToggle",
    "CopilotChatPrompts",
    "CopilotChatAgents",
    "CopilotChatModels",
  },
}

function M.config()
  require("CopilotChat").setup {
    sticky = {
      "#files",
    },
  }
  local wk = require "which-key"
  wk.add {
    { "<leader>C", group = "Copilot Chat", icon = "" },
    { "<leader>Cc", "<cmd>CopilotChat<cr>", desc = "Ask Copilot", icon = "󰭹" },
    { "<leader>Ct", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Chat" },
    { "<leader>Cp", "<cmd>CopilotChatPrompts<cr>", desc = "Prompt templates" },
    { "<leader>Ca", "<cmd>CopilotChatAgents<cr>", desc = "Select Agent" },
    { "<leader>Cm", "<cmd>CopilotChatModels<cr>", desc = "Select Model" },
  }
end

return M
