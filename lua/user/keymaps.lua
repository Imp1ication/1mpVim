-- Shorten function name --
local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Remap <Space> as leader key --
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Page up and down
keymap("n", "<C-u>", "15kzz", opts)
keymap("n", "<C-d>", "15jzz", opts)

-- Keep cursor at the middle after search jumping
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Move in warpline 
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "gj", "j", opts)
keymap("n", "gk", "k", opts)

-- Delete into void
keymap("n", "<leader>d", "\"_d", opts)

-- Replace all
keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows 
keymap("n", "<C-Up>", ":resize -2<Cr>", opts)
keymap("n", "<C-Down>", ":resize +2<Cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<Cr>", opts)
keymap("n", "<C- Right>", ":vertical resize -2<Cr>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<Cr>", opts)
keymap("n", "<S-h>", ":bprevious<Cr>", opts)

-- Add empty line without get into Insert mode 
keymap("n", "<Cr>", "o<Esc>k", opts)


-- Insert -- 
-- Press jk to exit insert mode 
keymap("i", "jj", "<Esc>", opts)
keymap("i", "jk", "<Esc>", opts)


-- Visual --
-- Stay in indent mode 
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Keep paste buffer after paste
keymap("v", "p", "\"_dP", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<Cr>gv=gv", opts)
keymap("v", "K", ":m '<-2<Cr>gv=gv", opts)

keymap("n", "<leader>e", ":Lexplor 20<Cr>", opts)
