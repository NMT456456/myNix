-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- o not insert mode
vim.keymap.set("n", "<Leader>o", "o<Esc>", opts)
vim.keymap.set("n", "<Leader>O", "O<Esc>", opts)

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Switch tab
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "<S-h>")
vim.keymap.set("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

-- remap back/fowrard
vim.keymap.set("n", "<A-o>", "<C-o>", { desc = "Go Back" })
vim.keymap.set("n", "<A-i>", "<C-i>", { desc = "Go Forward" })
