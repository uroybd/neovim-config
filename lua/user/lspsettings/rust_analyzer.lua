return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {                
        command = "clippy",
        extraArgs = { "--all-targets", "--all-features", "--", "-D",   "warnings" },
      },
      cargo = {
        allFeatures = true,
      },
      inlayHints = {
        enable = true,
        typeHints = { enable = true },
      },
    },
  },
}
