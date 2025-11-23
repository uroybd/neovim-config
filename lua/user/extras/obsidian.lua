local M = {
  "obsidian-nvim/obsidian.nvim",
  branch = "main",
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
    -- see below for full list of optional dependencies 👇
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
    completion = {
      blink = true,
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context: follow link, show notes with tag, or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
    wiki_link_func = "prepend_note_path",
    disable_frontmatter = true,
    -- note_frontmatter_func = function(note)
    --   -- Add the title of the note as an alias.
    --   if note.title then
    --     note:add_alias(note.title)
    --   end
    --   local timestamp = get_timestamp()
    --   note:add_field("updated", timestamp)
    --   if note.get_field "created" == nil then
    --     note:add_field("created", timestamp)
    --   end
    --
    --   local out = { aliases = note.aliases, tags = note.tags }
    --
    --   -- `note.metadata` contains any manually added fields in the frontmatter.
    --   -- So here we just make sure those fields are kept in the frontmatter.
    --   if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    --     for k, v in pairs(note.metadata) do
    --       out[k] = v
    --     end
    --   end
    --
    --   return out
    -- end,
  }
end

return M
