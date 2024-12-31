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
    },
    keymap = {
      preset = "enter",
    },

    appearance = {
      use_nvim_cmp_as_default = true,
    },
    completion = {
      list = {
        selection = function(ctx)
          return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect'
        end
      },
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline" or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
        end,
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      documentation = {
        auto_show = true,
        window = {
          border = "single",
        },
      },
    },
  }
end

return M
