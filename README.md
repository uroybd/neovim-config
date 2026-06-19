# Neovim Configuration

![Package Manager](https://img.shields.io/badge/Package_Manager-zpack.nvim-blue?style=flat-square) ![Leader Key](https://img.shields.io/badge/Leader_Key-Space-blue?style=flat-square) ![Plugins](https://img.shields.io/badge/Plugins-31-blue?style=flat-square)

My neovim config for version >= 0.12

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

<table>
<tr>
<td valign="top" width="50%">

<a target="_blank" href="https://github.com/arborist-ts/arborist.nvim"><img src="https://githubcard.com/arborist-ts/arborist.nvim.svg?d=JUwMjTqY" alt="arborist.nvim" /></a>
<a target="_blank" href="https://github.com/saghen/blink.cmp"><img src="https://githubcard.com/saghen/blink.cmp.svg?d=JUwMjTqY" alt="blink.cmp" /></a>
<a target="_blank" href="https://github.com/barrettruth/canola-collection"><img src="https://githubcard.com/barrettruth/canola-collection.svg?d=JUwMjTqY" alt="canola-collection" /></a>
<a target="_blank" href="https://github.com/barrettruth/canola.nvim"><img src="https://githubcard.com/barrettruth/canola.nvim.svg?d=JUwMjTqY" alt="canola.nvim" /></a>
<a target="_blank" href="https://github.com/esmuellert/codediff.nvim"><img src="https://githubcard.com/esmuellert/codediff.nvim.svg?d=JUwMjTqY" alt="codediff.nvim" /></a>
<a target="_blank" href="https://github.com/stevearc/conform.nvim"><img src="https://githubcard.com/stevearc/conform.nvim.svg?d=JUwMjTqY" alt="conform.nvim" /></a>
<a target="_blank" href="https://github.com/zbirenbaum/copilot.lua"><img src="https://githubcard.com/zbirenbaum/copilot.lua.svg?d=JUwMjTqY" alt="copilot.lua" /></a>
<a target="_blank" href="https://github.com/Bekaboo/dropbar.nvim"><img src="https://githubcard.com/Bekaboo/dropbar.nvim.svg?d=JUwMjTqY" alt="dropbar.nvim" /></a>
<a target="_blank" href="https://github.com/folke/flash.nvim"><img src="https://githubcard.com/folke/flash.nvim.svg?d=JUwMjTqY" alt="flash.nvim" /></a>
<a target="_blank" href="https://github.com/rafamadriz/friendly-snippets"><img src="https://githubcard.com/rafamadriz/friendly-snippets.svg?d=JUwMjTqY" alt="friendly-snippets" /></a>
<a target="_blank" href="https://github.com/lewis6991/gitsigns.nvim"><img src="https://githubcard.com/lewis6991/gitsigns.nvim.svg?d=JUwMjTqY" alt="gitsigns.nvim" /></a>
<a target="_blank" href="https://github.com/MagicDuck/grug-far.nvim"><img src="https://githubcard.com/MagicDuck/grug-far.nvim.svg?d=JUwMjTqY" alt="grug-far.nvim" /></a>
<a target="_blank" href="https://github.com/webhooked/kanso.nvim"><img src="https://githubcard.com/webhooked/kanso.nvim.svg?d=JUwMjTqY" alt="kanso.nvim" /></a>
<a target="_blank" href="https://github.com/mistweaverco/kulala.nvim"><img src="https://githubcard.com/mistweaverco/kulala.nvim.svg?d=JUwMjTqY" alt="kulala.nvim" /></a>
<a target="_blank" href="https://github.com/folke/lazydev.nvim"><img src="https://githubcard.com/folke/lazydev.nvim.svg?d=JUwMjTqY" alt="lazydev.nvim" /></a>
<a target="_blank" href="https://github.com/nvim-lualine/lualine.nvim"><img src="https://githubcard.com/nvim-lualine/lualine.nvim.svg?d=JUwMjTqY" alt="lualine.nvim" /></a>

</td>
<td valign="top" width="50%">

<a target="_blank" href="https://github.com/williamboman/mason-lspconfig.nvim"><img src="https://githubcard.com/williamboman/mason-lspconfig.nvim.svg?d=JUwMjTqY" alt="mason-lspconfig.nvim" /></a>
<a target="_blank" href="https://github.com/williamboman/mason.nvim"><img src="https://githubcard.com/williamboman/mason.nvim.svg?d=JUwMjTqY" alt="mason.nvim" /></a>
<a target="_blank" href="https://github.com/echasnovski/mini.icons"><img src="https://githubcard.com/echasnovski/mini.icons.svg?d=JUwMjTqY" alt="mini.icons" /></a>
<a target="_blank" href="https://github.com/mawkler/modicator.nvim"><img src="https://githubcard.com/mawkler/modicator.nvim.svg?d=JUwMjTqY" alt="modicator.nvim" /></a>
<a target="_blank" href="https://github.com/neogitorg/neogit"><img src="https://githubcard.com/neogitorg/neogit.svg?d=JUwMjTqY" alt="neogit" /></a>
<a target="_blank" href="https://github.com/windwp/nvim-autopairs"><img src="https://githubcard.com/windwp/nvim-autopairs.svg?d=JUwMjTqY" alt="nvim-autopairs" /></a>
<a target="_blank" href="https://github.com/neovim/nvim-lspconfig"><img src="https://githubcard.com/neovim/nvim-lspconfig.svg?d=JUwMjTqY" alt="nvim-lspconfig" /></a>
<a target="_blank" href="https://github.com/kylechui/nvim-surround"><img src="https://githubcard.com/kylechui/nvim-surround.svg?d=JUwMjTqY" alt="nvim-surround" /></a>
<a target="_blank" href="https://github.com/stevearc/overseer.nvim"><img src="https://githubcard.com/stevearc/overseer.nvim.svg?d=JUwMjTqY" alt="overseer.nvim" /></a>
<a target="_blank" href="https://github.com/b0o/schemastore.nvim"><img src="https://githubcard.com/b0o/schemastore.nvim.svg?d=JUwMjTqY" alt="schemastore.nvim" /></a>
<a target="_blank" href="https://github.com/folke/sidekick.nvim"><img src="https://githubcard.com/folke/sidekick.nvim.svg?d=JUwMjTqY" alt="sidekick.nvim" /></a>
<a target="_blank" href="https://github.com/folke/snacks.nvim"><img src="https://githubcard.com/folke/snacks.nvim.svg?d=JUwMjTqY" alt="snacks.nvim" /></a>
<a target="_blank" href="https://github.com/rachartier/tiny-cmdline.nvim"><img src="https://githubcard.com/rachartier/tiny-cmdline.nvim.svg?d=JUwMjTqY" alt="tiny-cmdline.nvim" /></a>
<a target="_blank" href="https://github.com/folke/which-key.nvim"><img src="https://githubcard.com/folke/which-key.nvim.svg?d=JUwMjTqY" alt="which-key.nvim" /></a>
<a target="_blank" href="https://github.com/zuqini/zpack.nvim"><img src="https://githubcard.com/zuqini/zpack.nvim.svg?d=JUwMjTqY" alt="zpack.nvim" /></a>

</td>
</tr>
</table>
