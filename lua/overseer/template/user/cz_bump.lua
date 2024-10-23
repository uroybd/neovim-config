return {
  name = "Commitizen Bump",
  builder = function()
    return {
      cmd = { "cz", "bump", "-at" },
      cwd = vim.fn.getcwd(),
    }
  end,
}
