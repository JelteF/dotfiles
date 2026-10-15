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

opt.mousemoveevent = true -- Enable mouse support in all modes

opt.listchars = {
  space = " ",
  tab = "> ",
  trail = "⋅",
  nbsp = "+",
}

-- Unmap default Ctrl+C usage in sql files...
-- https://stackoverflow.com/questions/24931088/disable-omnicomplete-or-ftplugin-or-something-in-vim
vim.g.omni_sql_no_default_maps = 1

-- Don't detect lua as root
vim.g.root_spec = { "lsp", ".git", "cwd" }

-- No animations
vim.g.snacks_animate = false

if vim.fn.executable("gpaste-client") == 1 then
  vim.g.clipboard = {
    name = "gpaste",
    copy = {
      ["+"] = { "gpaste-client" },
      ["*"] = { "gpaste-client" },
    },
    paste = {
      ["+"] = { "gpaste-client", "--use-index", "get", "0" },
      ["*"] = { "gpaste-client", "--use-index", "get", "0" },
    },
    cache_enabled = true,
  }
elseif vim.env.HERDR_ENV == "1" and vim.env.SSH_CONNECTION then
  -- herdr forwards OSC 52 writes but never answers OSC 52 read queries, so
  -- any read of the + register (yanky's focus sync, which-key's register
  -- preview, "+p) would block on "Waiting for OSC 52 response". Reads return
  -- nvim's own unnamed register instead; text from other apps can still be
  -- pasted with the terminal's own paste.
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  vim.g.clipboard = {
    name = "OSC 52 (herdr)",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end
