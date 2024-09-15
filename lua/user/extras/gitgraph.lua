local M = {
  "isakbm/gitgraph.nvim",
  dependencies = { "sindrets/diffview.nvim" },
  event = "VeryLazy",
}

function M.config()
  local gitgraph = require "gitgraph"
  gitgraph.setup {
    hooks = {
      -- Check diff of a commit
      on_select_commit = function(commit)
        vim.notify("DiffviewOpen " .. commit.hash .. "^!")
        vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
      end,
      -- Check diff from commit a -> commit b
      on_select_range_commit = function(from, to)
        vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
        vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
      end,
    },
    symbols = {
      merge_commit = "󰗠",
      commit = "",
      --   merge_commit_end = "",
      --   commit_end = "",
      --
      --   -- Advanced symbols
      --   GVER = "",
      --   GHOR = "",
      --   GCLD = "",
      --   GCRD = "╭",
      --   GCLU = "",
      --   GCRU = "",
      --   GLRU = "",
      --   GLRD = "",
      --   GLUD = "",
      --   GRUD = "",
      --   GFORKU = "",
      --   GFORKD = "",
      --   GRUDCD = "",
      --   GRUDCU = "",
      --   GLUDCD = "",
      --   GLUDCU = "",
      --   GLRDCL = "",
      --   GLRDCR = "",
      --   GLRUCL = "",
      --   GLRUCR = "",
    },
  }

  local wk = require "which-key"
  wk.add {
    {
      "<leader>gG",
      function()
        require("gitgraph").draw({}, { all = true, max_count = 5000 })
      end,
      desc = "Git Graph",
    },
  }
end

return M
