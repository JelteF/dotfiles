-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Remap for dealing with word wrap
local map = vim.keymap.set
map("x", "j", "mode() ==# 'v' && v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map("x", "<Down>", "mode() ==# 'v' && v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map("x", "k", "mode() ==# 'v' && v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map("x", "<Up>", "mode() ==# 'v' && v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Make `A` go to the end wrapping point of a wrapped line instead of the full end
map("n", "A", "g$a", { desc = "End of line", silent = true })

-- Easier split navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("i", "<C-h>", "<C-o><C-w>h")
map("i", "<C-j>", "<C-o><C-w>j")
map("i", "<C-k>", "<C-o><C-w>k")
map("i", "<C-l>", "<C-o><C-w>l")

-- Make Ctrl+C actually the same as escape
map({ "i", "v" }, "<C-c>", "<esc>")

-- map({ "n", "v" }, ",,", "<C-^>")

-- Make Ctrl+Shift+S save all
map("n", "<CS-s>", ":wa<CR>")
map("v", "<CS-s>", "<C-S>:wa<CR>")
map("i", "<CS-s>", "<C-O>:wa<CR>")

-- Make leader + t save all files
map("n", "<leader>t", ":wa<CR>", { desc = "Save all files" })

-- Allow copy pasting in WSL
map({ "v" }, "<F6>", '"+y<CR>')

-- Make ; the same as :
-- map("n", ";", ":")

-- Add toggle for highlight
-- map("n", ",/", ":nohls<CR>", { silent = true })

-- Stay in the middle of the screen
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- paste but don't replace paste buffer
-- map("x", "<leader>p", [["_dP]])
-- map({ "n", "v" }, "<leader>d", [["_d]])

-- Don't show this weird menu thing
map("n", "Q", "<nop>")

-- make current file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- shift + backspace to delete
map("i", "<S-BS>", "<del>")
