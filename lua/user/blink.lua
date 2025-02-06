local M = {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*", dependencies = { "rafamadriz/friendly-snippets" } },
  },

  -- use a release tag to download pre-built binaries
  version = "v0.*",
  -- branch="main"
}

function M.config()
  require("luasnip.loaders.from_vscode").lazy_load()
  require("blink.cmp").setup {
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    keymap = {
      preset = "super-tab",
    },

    appearance = {
      use_nvim_cmp_as_default = true,
    },
    completion = {
      list = {
        selection = {
          -- preselect = function(ctx)
          --   return ctx.mode ~= "cmdline"
          -- end,
          auto_insert = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
        },
      },
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
        end,
        border = "single",
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
