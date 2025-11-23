local M = {
  "daliusd/ghlite.nvim",
  event = "VeryLazy",
  dependencies = {
    { "sindrets/diffview.nvim" },
  },
}

function M.config()
  require("ghlite").setup {
    view_split = "",
    debug = true,
  }
  local wk = require "which-key"
  wk.add {
    { "<leader>u", group = "GHLite" },
    { "<leader>us", ":GHLitePRSelect<cr>", desc = "PR Select" },
    { "<leader>uo", ":GHLitePRCheckout<cr>", desc = "PR Checkout" },
    { "<leader>uv", ":GHLitePRView<cr>", desc = "PR View" },
    { "<leader>uu", ":GHLitePRLoadComments<cr>", desc = "PR Load Comments" },
    { "<leader>up", ":GHLitePRDiff<cr>", desc = "PR Diff" },
    { "<leader>ua", ":GHLitePRAddComment<cr>", desc = "PR Add comment" },
    { "<leader>ua", ":GHLitePRAddComment<cr>", mode = "x", desc = "PR Add comment" },
    { "<leader>uc", ":GHLitePRUpdateComment<cr>", desc = "PR Update comment" },
    { "<leader>ud", ":GHLitePRDeleteComment<cr>", desc = "PR Delete comment" },
    { "<leader>ug", ":GHLitePROpenComment<cr>", desc = "PR Open comment" },
    { "<leader>ul", ":GHLitePRDiffview<cr>", silent = true, desc = "PR Diffview" },
  }
end

return M
