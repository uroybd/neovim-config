return {
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
				extraArgs = { "--all-targets", "--all-features", "--", "-D", "warnings" },
			},
			cargo = {
				allFeatures = true,
			},
			inlayHints = {
				enable = true,
				typeHints = { enable = true },
			},
			diagnostics = {
				enable = true,
			},
		},
	},
}
