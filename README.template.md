# Neovim Configuration

<BADGES>

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

<PLUGINS>
