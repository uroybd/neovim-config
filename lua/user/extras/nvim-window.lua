local M = {
  "yorickpeterse/nvim-window",
  branch = "main",
}

function M.config()
  local nvim_window = require "nvim-window"
  nvim_window.setup {
    normal_hl = "@comment.warning",
    border = "none",
    chars = {
      "a",
      "s",
      "d",
      "f",
      "g",
      "h",
      "j",
      "k",
      "l",
    },
  }
  local wk = require "which-key"
  wk.add {
    {
      "\\",
      function()
        require("nvim-window").pick()
      end,
      desc = "Window Jump",
      mode = {
        "n",
        "v",
      },
    },
  }
end

return M
