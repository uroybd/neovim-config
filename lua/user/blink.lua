local M = {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = {
    { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
  },

  -- use a release tag to download pre-built binaries
  version = "v0.*",
  -- branch="main"
}

function M.config()
  -- require("luasnip").setup {}
  require("luasnip.loaders.from_vscode").lazy_load()
  require("blink.cmp").setup {
    snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },
    sources = {
      default = { "lsp", "path", "luasnip", "buffer" },
      -- cmdline = {},
    },
    keymap = { preset = "enter" },

    appearance = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = true,
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      documentation = {
        auto_show = true,
      },
    },
  }
end

return M
