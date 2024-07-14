-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opt = vim.opt

-- Enable line wrapping and breakindent
opt.wrap = true
opt.breakindent = true
opt.breakindentopt = "shift:6"

-- Add a line at 80 characters
opt.colorcolumn = "80"

opt.scrolloff = 7 -- lines of context at top and bottom of screen

opt.tabstop = 4 -- Number of spaces tabs count for
opt.shiftwidth = 4 -- Size of an indent

-- Unmap default Ctrl+C usage in sql files...
-- https://stackoverflow.com/questions/24931088/disable-omnicomplete-or-ftplugin-or-something-in-vim
vim.g.omni_sql_no_default_maps = 1

-- Don't detect lua as root
vim.g.root_spec = { "lsp", ".git", "cwd" }
