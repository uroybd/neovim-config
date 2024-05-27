local M = { 'echasnovski/mini.ai', version = '*' }

function M.config()
  local gen_spec = require('mini.ai').gen_spec
  require('mini.ai').setup({
     custom_textobjects = {
      b = false,
      F = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
      o = gen_spec.treesitter({
        a = { '@conditional.outer', '@loop.outer' },
        i = { '@conditional.inner', '@loop.inner' },
      })
    }
  })
end

return M
