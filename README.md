# Neovim Configuration

## File Structure and Loading Sequence

When Neovim starts, files are loaded in this specific order:

1. **`init.lua`** - Entry point that orchestrates the entire configuration
   - Requires `config.options` - Sets editor options (line numbers, tabs, etc.)
   - Requires `config.lazy` - Bootstraps and configures the plugin manager
   - Requires `config.keymaps` - Sets up custom keybindings
   - Requires `config.terminal` - Configures terminal integration

2. **`lua/config/options.lua`** - Basic Vim options
   - Sets line numbers, relative numbers, tabs/spaces
   - Configures search, clipboard, and UI settings
   - Establishes core editor behavior before plugins load

3. **`lua/config/lazy.lua`** - Plugin management
   - Bootstraps lazy.nvim if not installed
   - Defines all plugin specifications
   - Manages plugin loading (immediate vs lazy-loaded)
   - Configures each plugin's setup

4. **`lua/config/keymaps.lua`** - Global keybindings
   - Defines leader key and custom mappings
   - Sets up window navigation and management
   - Loaded after plugins to ensure commands are available

5. **`lua/config/terminal.lua`** - Terminal configuration
   - Sets up terminal-specific keybindings
   - Configures shell integration

### Unused Files
The following files exist but are not currently loaded:
- `lua/keymaps.lua`, `lua/plugins.lua`, `lua/settings.lua` - Orphaned configuration files
- `after/` directory - Empty, reserved for post-plugin overrides

## Features

- **Plugin Manager**: Lazy.nvim for efficient plugin loading
- **Colorscheme**: Tokyo Night theme
- **File Management**: Neo-tree file explorer, Oil.nvim file manager
- **Git Integration**: Gitsigns, Fugitive, LazyGit
- **Formatting**: Conform.nvim with support for multiple languages
- **Fuzzy Finding**: Telescope with FZF backend
- **Syntax Highlighting**: Tree-sitter
- **Terminal Integration**: ToggleTerm
- **AI Assistance**: Claude Code integration via claude-code.nvim
- **Quick Navigation**: Harpoon for file marks
- **History**: Undotree for visualizing undo history

## Key Bindings

### General
- `<Space>` - Leader key
- `<leader>w` - Save file
- `<leader>q` - Quit

### File Navigation
- `<leader>e` - Toggle Neo-tree file explorer
- `-` - Open Oil.nvim (browse parent directory)

### Telescope (Fuzzy Finding)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Browse buffers
- `<leader>fh` - Help tags
- `<leader>fr` - Recent files

### Git
- `<leader>gs` - Git status (Fugitive)
- `<leader>gg` - LazyGit

### Terminal
- `<leader>tt` - Toggle terminal
- `<leader>tf` - Float terminal
- `<leader>th` - Horizontal terminal
- `<leader>tv` - Vertical terminal
- `<C-\>` - Toggle terminal (from any mode)

### Harpoon (Quick File Access)
- `<leader>a` - Add file to Harpoon
- `<C-e>` - Open Harpoon menu
- `<leader>1-4` - Jump to Harpoon file 1-4

### Code Editing
- `<leader>f` - Format buffer
- `<leader>u` - Toggle Undotree
- `<leader>s` - Replace word under cursor

### Claude Code AI
- `<leader>cc` - Toggle Claude Code terminal window

### Window Management
- `<C-h/j/k/l>` - Navigate windows
- `<C-Up/Down/Left/Right>` - Resize windows

## Required External Tools

For full functionality, install these tools:

```bash
# Formatters
npm install -g prettier
pip install black
brew install stylua

# Other utilities
brew install ripgrep fd lazygit

# Claude Code CLI (if using claude-code.nvim)
# Follow installation instructions at:
# https://github.com/greggh/claude-code.nvim
```

## Plugin Loading Strategy

Plugins are loaded in two ways:
- **Immediate** (`lazy = false`): Loads at startup (e.g., colorscheme, claude-code.nvim)
- **Lazy-loaded**: Loads on-demand via:
  - `event`: On specific events (e.g., `BufReadPre`)
  - `cmd`: When command is used (e.g., `:Telescope`)
  - `keys`: When keybinding is pressed (e.g., `<leader>e` for Neo-tree)

This optimizes startup time by only loading plugins when needed.