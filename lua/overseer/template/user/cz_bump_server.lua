return {
  name = "Commitizen Bump in Server",
  builder = function()
    -- Full path to current file (see :help expand())
    local server_dir = vim.fn.getcwd() .. "/server"
    return {
      cmd = { "cz", "bump", "-at" },
      cwd = server_dir,
    }
  end,
}
