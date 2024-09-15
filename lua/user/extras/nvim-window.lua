local M = {
  "yorickpeterse/nvim-window",
}

function M.config()
  local nvim_window = require "nvim-window"
  nvim_window.setup { normal_hl = "@comment.warning", border = "none" }
  local wk = require "which-key"
  wk.add {
    {
      "<leader>,",
      function()
        require("nvim-window").pick()
      end,
      desc = "Window Jump",
    },
  }
end

return M
