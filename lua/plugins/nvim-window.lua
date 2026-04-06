local M = {
  "yorickpeterse/nvim-window",
  keys = {
    {
      "\\",
      function()
        require("nvim-window").pick()
      end,
      mode = { "n", "v" },
      desc = "Window Jump",
    },
  },
  opts = {
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
  },
}

return M
