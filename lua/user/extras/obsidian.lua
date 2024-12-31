local M = {
  "epwalsh/obsidian.nvim",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function get_timestamp()
  -- get ISO 8601 timestamp with offset
  return os.date "%Y-%m-%dT%H:%M:%S+06:00"
end

function M.config()
  require("obsidian").setup {
    ui = { enable = false },
    workspaces = {
      {
        name = "The Codex",
        path = "~/Documents/The Codex/",
      },
    },
    notes = "Scratchpad",
    wiki_link_func = "prepend_note_path",
    disable_frontmatter = true,
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { aliases = note.aliases, tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
        out.updated = get_timestamp()
        if not out.created then
          out.created = get_timestamp()
        end
      end

      return out
    end,
  }
end

return M
