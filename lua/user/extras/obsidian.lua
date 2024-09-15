local M = {
  "epwalsh/obsidian.nvim",
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
}

function M.config()
  require("obsidian").setup({
    ui = { enable = false },
    workspaces = {

      {
        name = "The Codex",
        path = "~/Documents/The Codex/",
      },
    },
    notes = "Scratchpad",
    wiki_link_func = "prepend_note_path"
  })
end

return M
