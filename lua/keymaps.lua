-- ~/.config/nvim/lua/keymaps.lua

-- Set <Space> as leader key
vim.g.mapleader = " "

-- Easier save & quit
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Navigate splits with Ctrl-h/j/k/l
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right" })

-- Clear search highlight with <leader>h
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })
