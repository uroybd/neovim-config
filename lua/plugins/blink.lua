local M = {
  "saghen/blink.cmp",
  branch = "v1",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = "InsertEnter",
  opts = {
    fuzzy = {
      implementation = "prefer_rust",
    },
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
            return not require("blink.cmp").snippet_active({ direction = 1 })
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
        function()
          return require("sidekick").nes_jump_or_apply()
        end,
        "fallback",
      },
    },
  },
}

function M.build()
  -- Auto-build Rust binary after install/update
  vim.cmd("BlinkCmpBuild")
end

return M
