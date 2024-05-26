local M = {
  "desdic/marlin.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}

function M.config()

  local opts = {
        -- open_callback = require("marlin.callbacks").use_split,
        patterns = { ".git", ".svn", "Makefile", "Cargo.toml", "." },
    }
  local marlin = require("marlin")
  marlin.setup(opts)
  local mindex = 0
  local generate_finder = function()
      mindex = 0
      return require("telescope.finders").new_table({
          results = require("marlin").get_indexes(),
          entry_maker = function(entry)
              mindex = mindex + 1
              return {
                  value = entry,
                  ordinal = mindex .. ":" .. entry.filename,
                  lnum = entry.row,
                  col = entry.col + 1,
                  filename = entry.filename,
                  display = mindex .. ":" .. entry.filename .. ":" .. entry.row .. ":" .. entry.col,
              }
          end,
      })
  end
  local keymap = vim.keymap.set
  keymap("n", "<s-m>", function() marlin.add() end, {desc = "Mark file with marlin"})
  keymap("n", "<TAB>", function()
              local conf = require("telescope.config").values
                local action_state = require("telescope.actions.state")

              require("telescope.pickers")
                  .new({}, {
                  prompt_title = "Marlin",
                  finder = generate_finder(),
                  previewer = conf.grep_previewer({}),
                  sorter = conf.generic_sorter({}),
                  attach_mappings = function(_, map)
                        map("i", "<c-d>", function(bufnr)
                          local current_picker = action_state.get_current_picker(bufnr)
                          current_picker:delete_selection(function(selection)
                              require("marlin").remove(selection.filename)
                          end)
                      end)
                        map("i", "+", function(bufnr)
                          local current_picker = action_state.get_current_picker(bufnr)
                          local selection = current_picker:get_selection()
                          require("marlin").move_up(selection.filename)
                          current_picker:refresh(generate_finder(), {})
                      end)
                        map("i", "-", function(bufnr)
                          local current_picker = action_state.get_current_picker(bufnr)
                          local selection = current_picker:get_selection()
                          require("marlin").move_down(selection.filename)
                          current_picker:refresh(generate_finder(), {})
                      end)
                        return true
                    end,
              })
                  :find()
          end, {desc = "Toggle Marlin"})
  for index = 1,4 do
    keymap("n", "<Leader>"..index, function() marlin.open(index) end, {  desc = "goto "..index })
  end
  local wk = require("which-key")
  wk.register({
    ["<leader>f["] = { function() marlin.next() end, "Next file"},
    ["<leader>f]"] = { function() marlin.prev() end, "Previous file"},
  })
end

return M
