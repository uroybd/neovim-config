local Snacks = require('snacks')

local M = {}

local function get_tabs()
  local tabs = {}
  local tabpages = vim.api.nvim_list_tabpages()
  for i, tabpage in ipairs(tabpages) do
    local wins = vim.api.nvim_tabpage_list_wins(tabpage)
    local cur_win = vim.api.nvim_tabpage_get_win(tabpage)
    local buf = vim.api.nvim_win_get_buf(cur_win)
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':t')
    if name == '' then name = '[No Name]' end
    table.insert(tabs, {
      idx = i,
      text = ('Tab %d: %s'):format(i, name),
      tabnr = i,
      tabpage = tabpage,
    })
  end
  return tabs
end

function M.tabs_picker()
  local items = get_tabs()
  Snacks.picker({
    title = 'Tabs',
    items = items,
    format = 'text',
    confirm = function(picker, item)
      picker:close()
      vim.cmd(('tabnext %d'):format(item.tabnr))
    end,
    layout = {
      preset = 'select',
      preview = false,
    },
    preview = 'preview',
    actions = {
      close_tab = function(picker, item)
        picker:close()
        vim.cmd(('tabclose %d'):format(item.tabnr))
      end,
    },
    win = {
      input = {
        keys = {
          ['d'] = 'close_tab',
        },
      },
    },
  })
end

return M
