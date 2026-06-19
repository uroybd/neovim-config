# Neovim Configuration

![Package Manager](https://img.shields.io/badge/Package_Manager-zpack.nvim-blue?style=for-the-badge&logo=neovim) ![Leader Key](https://img.shields.io/badge/Leader_Key-Space-blue?style=for-the-badge&logo=neovim) ![Plugins](https://img.shields.io/badge/Plugins-31-blue?style=for-the-badge&logo=neovim)

My neovim config for version `>= 0.12`

## Setup

1. Clone this repository to your Neovim config directory:
   ```bash
   git clone https://github.com/uroybd/neovim-config ~/.config/nvim
   ```

2. Ensure you have Neovim 0.12.0 or later:
   ```bash
   nvim --version
   ```

3. Start Neovim - plugins will be automatically downloaded on first run:
   ```bash
   nvim
   ```

## Configuration Philosophy
Let's just admit, I like eyecandies. So, I will not go ultra-minimal with UI tweaks. But, I will not go overboard also. That is why, instead of full-fledged `noice.nvim`, I used `tiny-cmdline` to bring command pane to the center, to my eye level. Yet, I couldn't do away with `modicator` which somehow helps me to recognize the active easily with it's synchronised per-mode color. It creates a vibe around the editor that I don't actively notice but I notice alright.

I chose `ZPack` as the middle ground between native `vim.pack` (It is a wrapper around that), and `lazy.nvim` (which is bulkier) to organize and manage my plugins.

I try to keep deprecated plugins at bay. Currently, `arborist.nvim` manages the `treesitter` queries. `Canola.nvim` replaced `Oil.nvim`.

Ergonomics, however, is the most important thing, and is mostly subjective. Hence, the particular choices of `flash.nvim` for jump and selection. single-key window picker powered by `snacks.nvim`. `Neogit`, `Canola/Oil` because I found them easier and predictable to use.

## Plugins

<p align="center">
<img src="https://githubcard.com/arborist-ts/arborist.nvim.svg?d=V24f0SDc" width="45%" alt="arborist.nvim" />
<img src="https://githubcard.com/saghen/blink.cmp.svg?d=V24f0SDc" width="45%" alt="blink.cmp" />
<img src="https://githubcard.com/barrettruth/canola-collection.svg?d=V24f0SDc" width="45%" alt="canola-collection" />
<img src="https://githubcard.com/barrettruth/canola.nvim.svg?d=V24f0SDc" width="45%" alt="canola.nvim" />
<img src="https://githubcard.com/esmuellert/codediff.nvim.svg?d=V24f0SDc" width="45%" alt="codediff.nvim" />
<img src="https://githubcard.com/stevearc/conform.nvim.svg?d=V24f0SDc" width="45%" alt="conform.nvim" />
<img src="https://githubcard.com/zbirenbaum/copilot.lua.svg?d=V24f0SDc" width="45%" alt="copilot.lua" />
<img src="https://githubcard.com/Bekaboo/dropbar.nvim.svg?d=V24f0SDc" width="45%" alt="dropbar.nvim" />
<img src="https://githubcard.com/folke/flash.nvim.svg?d=V24f0SDc" width="45%" alt="flash.nvim" />
<img src="https://githubcard.com/rafamadriz/friendly-snippets.svg?d=V24f0SDc" width="45%" alt="friendly-snippets" />
<img src="https://githubcard.com/lewis6991/gitsigns.nvim.svg?d=V24f0SDc" width="45%" alt="gitsigns.nvim" />
<img src="https://githubcard.com/MagicDuck/grug-far.nvim.svg?d=V24f0SDc" width="45%" alt="grug-far.nvim" />
<img src="https://githubcard.com/webhooked/kanso.nvim.svg?d=V24f0SDc" width="45%" alt="kanso.nvim" />
<img src="https://githubcard.com/mistweaverco/kulala.nvim.svg?d=V24f0SDc" width="45%" alt="kulala.nvim" />
<img src="https://githubcard.com/folke/lazydev.nvim.svg?d=V24f0SDc" width="45%" alt="lazydev.nvim" />
<img src="https://githubcard.com/nvim-lualine/lualine.nvim.svg?d=V24f0SDc" width="45%" alt="lualine.nvim" />
<img src="https://githubcard.com/williamboman/mason-lspconfig.nvim.svg?d=V24f0SDc" width="45%" alt="mason-lspconfig.nvim" />
<img src="https://githubcard.com/williamboman/mason.nvim.svg?d=V24f0SDc" width="45%" alt="mason.nvim" />
<img src="https://githubcard.com/echasnovski/mini.icons.svg?d=V24f0SDc" width="45%" alt="mini.icons" />
<img src="https://githubcard.com/mawkler/modicator.nvim.svg?d=V24f0SDc" width="45%" alt="modicator.nvim" />
<img src="https://githubcard.com/neogitorg/neogit.svg?d=V24f0SDc" width="45%" alt="neogit" />
<img src="https://githubcard.com/windwp/nvim-autopairs.svg?d=V24f0SDc" width="45%" alt="nvim-autopairs" />
<img src="https://githubcard.com/neovim/nvim-lspconfig.svg?d=V24f0SDc" width="45%" alt="nvim-lspconfig" />
<img src="https://githubcard.com/kylechui/nvim-surround.svg?d=V24f0SDc" width="45%" alt="nvim-surround" />
<img src="https://githubcard.com/stevearc/overseer.nvim.svg?d=V24f0SDc" width="45%" alt="overseer.nvim" />
<img src="https://githubcard.com/b0o/schemastore.nvim.svg?d=V24f0SDc" width="45%" alt="schemastore.nvim" />
<img src="https://githubcard.com/folke/sidekick.nvim.svg?d=V24f0SDc" width="45%" alt="sidekick.nvim" />
<img src="https://githubcard.com/folke/snacks.nvim.svg?d=V24f0SDc" width="45%" alt="snacks.nvim" />
<img src="https://githubcard.com/rachartier/tiny-cmdline.nvim.svg?d=V24f0SDc" width="45%" alt="tiny-cmdline.nvim" />
<img src="https://githubcard.com/folke/which-key.nvim.svg?d=V24f0SDc" width="45%" alt="which-key.nvim" />
<img src="https://githubcard.com/zuqini/zpack.nvim.svg?d=V24f0SDc" width="45%" alt="zpack.nvim" />
</p>
