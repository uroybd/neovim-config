local filetype_doc_map = {
  "go",
  { "python", "python~3.13" },
}

local function get_source_from_filetype(filetype)
  for _, ft in ipairs(filetype_doc_map) do
    if type(ft) == "string" and ft == filetype then
      return ft
    elseif type(ft) == "table" and ft[1] == filetype then
      return ft[2]
    end
  end
  return filetype
end

local M = {
  "emmanueltouzery/apidocs.nvim",
  cmd = { "ApidocsSearch", "ApidocsInstall", "ApidocsOpen", "ApidocsUninstall" },
  keys = {
    { "<leader>Do", "<cmd>ApidocsOpen<cr>", desc = "Open Apidocs" },
    { "<leader>Ds", "<cmd>ApidocsSearch<cr>", desc = "Search Apidocs" },
    {
      "<leader>Dco",
      function()
        local ft = vim.bo.filetype
        local source = get_source_from_filetype(ft)
        require("apidocs").apidocs_open { restrict_sources = { source } }
      end,
      desc = "Open Apidocs",
    },
    {
      "<leader>Dcs",
      function()
        local ft = vim.bo.filetype
        local source = get_source_from_filetype(ft)
        require("apidocs").apidocs_search { restrict_sources = { source } }
      end,
      desc = "Search Apidocs",
    },
  },
}

function M.config()
  require("apidocs").setup {
    picker = "snacks",
  }
end

return M
