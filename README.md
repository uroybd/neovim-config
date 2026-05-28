# Neovim Configuration

My neovim config for version >= 0.12

## Setup

1. Clone this repository to your Neovim config directory:
   ```bash
   git clone <repo-url> ~/.config/nvim
   ```

2. Ensure you have Neovim 0.12.0 or later:
   ```bash
   nvim --version
   ```

3. Start Neovim - plugins will be automatically downloaded on first run:
   ```bash
   nvim
   ```

4. Mason will auto-install LSP servers and formatters

## Directory Structure

```
nvim-pack/
├── init.lua              # Main entry point, sets up Lua path
├── plugin/               # Plugin configurations (auto-loaded)
│   ├── 00-XX-*.lua      # Foundation (options, keymaps, autocmds)
│   ├── 01-XX-*.lua      # UI plugins (snacks, colorscheme, statusline)
│   ├── 02-XX-*.lua      # LSP & editing tools
│   └── 03-XX-*.lua      # Advanced tools (copilot, neotest, etc.)
├── ftplugin/             # Filetype-specific settings
│   └── rust.lua         # Rust configuration with rustaceanvim
└── user/                 # Custom user modules
    ├── icons.lua        # Icon definitions
    └── lspsettings/     # Per-LSP custom configurations
```
