local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix" })
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list" })
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location list" })

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

keymap.set("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right" })
keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below" })

keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })