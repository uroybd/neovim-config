local M = {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
  },
  lazy = true,
}

function M.config()
  local dap, dapui = require "dap", require "dapui"
  local dapgo = require "dap-go"
  dapui.setup()
  dapgo.setup {
    delve = {
      detached = false,
    },
  }
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end

  -- Include the next few lines until the comment only if you feel you need it
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
  -- Include everything after this

  local wk = require "which-key"

  wk.add {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<Leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<Leader>dB",
      function()
        require("dap").set_breakpoint()
      end,
      desc = "Set Breakpoint",
    },
    {
      "<Leader>dL",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
      end,
      desc = "Log Point",
    },
    {
      "<Leader>dr",
      function()
        require("dap").repl.open()
      end,
      desc = "Open Repl",
    },
    {
      "<Leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last",
    },
    {
      "<Leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle UI",
    },
    {
      "<Leader>de",
      function()
        require("dapui").eval()
      end,
      desc = "Evaluate",
    },
  }
end

return M
