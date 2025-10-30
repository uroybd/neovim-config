local M = {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = { "rafamadriz/friendly-snippets" },

  -- use a release tag to download pre-built binaries
  version = "v1.*",
  -- branch="main"
}

function M.config()
  require("blink.cmp").setup {
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = { enabled = true, window = { border = "single" } },
    completion = {
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        },
        border = "single",
      },
      documentation = {
        auto_show = true,
        window = { border = "single" },
      },
      list = {
        selection = {
          auto_insert = true,
          preselect = function(ctx)
            return not require("blink.cmp").snippet_active { direction = 1 }
          end,
        },
      },
    },
    keymap = {
      preset = "super-tab",
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        function() -- sidekick next edit suggestion
          return require("sidekick").nes_jump_or_apply()
        end,
        "fallback",
      },
    },
  }
end

return M
