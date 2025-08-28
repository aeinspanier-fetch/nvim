# Neovim Configuration

## Features

- **Plugin Manager**: Lazy.nvim for efficient plugin loading
- **Colorscheme**: Tokyo Night theme
- **File Management**: Neo-tree file explorer, Oil.nvim file manager
- **Git Integration**: Gitsigns, Fugitive, LazyGit
- **Formatting**: Conform.nvim with support for multiple languages
- **Fuzzy Finding**: Telescope with FZF backend
- **Syntax Highlighting**: Tree-sitter
- **Terminal Integration**: ToggleTerm with zsh support
- **Claude Integration**: Claude.nvim for AI assistance
- **Quick Navigation**: Harpoon for file marks

## Key Bindings

### General
- `<Space>` - Leader key
- `<leader>w` - Save file
- `<leader>q` - Quit

### File Navigation
- `<leader>e` - Toggle Neo-tree file explorer
- `<leader>pv` - Open netrw
- `-` - Open Oil.nvim (parent directory)
- `<leader>cd` - Quick change directory

### Telescope (Fuzzy Finding)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Browse buffers
- `<leader>fh` - Help tags
- `<leader>fr` - Recent files
- `/` - Fuzzy find in current buffer

### Git
- `<leader>gs` - Git status (Fugitive)
- `<leader>gg` - LazyGit
- `<leader>gd` - Git diff
- `<leader>gb` - Git blame
- `]h` / `[h` - Navigate git hunks

### Terminal
- `<leader>tt` - Toggle terminal
- `<leader>tf` - Float terminal
- `<leader>th` - Horizontal terminal
- `<leader>tv` - Vertical terminal
- `<leader>tc` - Open Claude Code in terminal
- `<C-\>` - Toggle terminal (from any mode)
- `<Esc><Esc>` - Exit terminal mode

### Harpoon (Quick File Access)
- `<leader>a` - Add file to Harpoon
- `<C-e>` - Open Harpoon menu
- `<leader>1-4` - Jump to Harpoon file 1-4

### Code Editing
- `<leader>f` - Format buffer
- `<leader>l` - Trigger linting
- `<leader>u` - Toggle Undotree
- `<leader>s` - Replace word under cursor

### Claude AI
- `<leader>cc` - Open Claude chat
- `<leader>ca` - Ask Claude about selection (visual mode)

### Window Management
- `<leader>|` - Split vertical
- `<leader>-` - Split horizontal
- `<C-h/j/k/l>` - Navigate windows
- `<C-Arrow>` - Resize windows

### Tabs
- `<leader><tab><tab>` - New tab
- `<leader><tab>]` - Next tab
- `<leader><tab>[` - Previous tab
- `<leader><tab>d` - Close tab

## Required External Tools

For full functionality, install these tools:

```bash
# Formatters
npm install -g prettier
pip install black stylua
brew install shfmt

# Linters
npm install -g eslint_d
pip install pylint
brew install luacheck

# Other
brew install ripgrep fd lazygit
```

## Claude API Setup

To use Claude integration, set your API key:

```bash
export CLAUDE_API_KEY="your-api-key-here"
```

Add this to your shell configuration file (~/.zshrc or ~/.bashrc).