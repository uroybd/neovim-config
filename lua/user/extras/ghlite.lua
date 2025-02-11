local M = {
  "daliusd/ghlite.nvim",
  dependencies = {
    "sindrets/diffview.nvim",
  },
}

function M.config()
  require("ghlite").setup {}
  local wk = require "which-key"
  wk.add {
    { "<leader>us", ":GHLitePRSelect<cr>", silent = true, desc = "PR Select" },
    { "<leader>uo", ":GHLitePRCheckout<cr>", silent = true, desc = "PR Checkout" },
    { "<leader>uv", ":GHLitePRView<cr>", silent = true, desc = "PR View" },
    { "<leader>uu", ":GHLitePRLoadComments<cr>", silent = true, desc = "PR Load Comments" },
    { "<leader>up", ":GHLitePRDiff<cr>", silent = true, desc = "PR Diff" },
    { "<leader>ul", ":GHLitePRDiffview<cr>", silent = true, desc = "PR Diffview" },
    { "<leader>ua", ":GHLitePRAddComment<cr>", silent = true, desc = "PR Add comment" },
    { "<leader>ua", ":GHLitePRAddComment<cr>", mode = "x", silent = true, desc = "PR Add comment" },
    { "<leader>uc", ":GHLitePRUpdateComment<cr>", silent = true, desc = "PR Update comment" },
    { "<leader>ud", ":GHLitePRDeleteComment<cr>", silent = true, desc = "PR Delete comment" },
    { "<leader>ug", ":GHLitePROpenComment<cr>", silent = true, desc = "PR Open comment" },
  }
end

return M
