local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  -- Git related plugins
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Allow importing LSP settings from vscode files
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    dependencies = {
      'neovim/nvim-lspconfig',
    },
  },

  { 'VonHeikemen/lsp-zero.nvim', branch = 'dev-v3' },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      -- linters/formatters pretending to be LSPs
      'jose-elias-alvarez/null-ls.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  { 'folke/which-key.nvim',      opts = {} },

  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>vh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Pre[V]iew [H]unk' })
      end,
    },
  },

  -- {
  --   -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },
  -- {
  --   'chriskempson/base16-vim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'base16-harmonic-dark'
  --   end,
  -- },
  -- {
  --   'echasnovski/mini.base16',
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      inactive_sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
        lualine_z = {
          { 'location' },
          {
            function()
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_get_option(buf, 'modified') then
                  return '[+]' -- any message or icon
                end
              end
              return ''
            end,
          },
        },
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',          opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
    },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
            mappings = {
              i = {
                ["<cr>"] = require("telescope-undo.actions").restore,
              }
            }
          },
        },
      })
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    },
    build = ':TSUpdate',
  },

  {
    'Wansmer/treesj',
    keys = { '<leader>m', '<leader>j', '<leader>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  -- rainbow braces
  { 'HiPhish/rainbow-delimiters.nvim' },

  -- official copilot
  -- { 'github/copilot.vim' },
  -- lua copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
      }
    },
    dependencies = {
      "zbirenbaum/copilot-cmp",
    }
  },
})


-- require('mini.base16').setup({
--   palette = {
--     base00 = '#112641',
--     base01 = '#3a475e',
--     base02 = '#606b81',
--     base03 = '#8691a7',
--     base04 = '#d5dc81',
--     base05 = '#e2e98f',
--     base06 = '#eff69c',
--     base07 = '#fcffaa',
--     base08 = '#ffcfa0',
--     base09 = '#cc7e46',
--     base0A = '#46a436',
--     base0B = '#9ff895',
--     base0C = '#ca6ecf',
--     base0D = '#42f7ff',
--     base0E = '#ffc4ff',
--     base0F = '#00a5c5',
--   },
--   use_cterm = true,
--   plugins = {
--     default = false,
--     ['echasnovski/mini.nvim'] = true,
--   },
-- })
-- require("copilot").setup({})

-- Don't highlight after search
-- vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.breakindentopt = 'shift:6'

-- Tabs and Indents that do the right thing by default
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Better split window opening
vim.o.splitbelow = true
vim.o.splitright = true

-- Show tabs and trailing white space
vim.o.list = true
vim.o.listchars = 'tab:>-,trail:~'

-- Always show numbers
vim.o.number = true;

-- Always show the a few lines below the cursor unless at the end of the file
vim.o.scrolloff = 7

-- Add a line at 80 characters
vim.o.colorcolumn = '80'

-- Show shared status line
vim.o.laststatus = 3

-- Make space leader work
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('v', 'k', "mode() ==# 'v' && v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('v', 'j', "mode() ==# 'v' && v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- This is a hack to make `A` work better when wrap and linebreak are true
BetterA = function()
  vim.cmd.normal('g$')
  local wrappos = vim.fn.getcurpos()
  vim.cmd.normal('$')
  local fullend = vim.fn.getcurpos()
  vim.fn.setpos('.', wrappos)
  if wrappos[3] == fullend[3] then
    vim.fn.feedkeys 'a'
  else
    vim.fn.feedkeys 'i'
  end
end

vim.keymap.set('n', 'A', ':call v:lua.BetterA()<CR>', { silent = true })


-- Easier split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('i', '<C-h>', '<C-o><C-w>h')
vim.keymap.set('i', '<C-j>', '<C-o><C-w>j')
vim.keymap.set('i', '<C-k>', '<C-o><C-w>k')
vim.keymap.set('i', '<C-l>', '<C-o><C-w>l')

-- Make Ctrl+C actually the same as escape
vim.keymap.set({ 'i', 'v' }, '<C-c>', '<esc>')
-- Unmap default Ctrl+C usage in sql files...
-- https://stackoverflow.com/questions/24931088/disable-omnicomplete-or-ftplugin-or-something-in-vim
vim.g.omni_sql_no_default_maps = 1

vim.keymap.set({ 'n', 'v' }, ',,', '<C-^>')

-- Make Ctrl+S save
vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('v', '<C-s>', '<C-S>:w<CR>')
vim.keymap.set('i', '<C-s>', '<C-O>:w<CR>')

-- Make Ctrl+Shift+S save all
vim.keymap.set('n', '<CS-s>', ':wa<CR>')
vim.keymap.set('v', '<CS-s>', '<C-S>:wa<CR>')
vim.keymap.set('i', '<CS-s>', '<C-O>:wa<CR>')

-- Make leader + h save all files
vim.keymap.set('n', '<leader>h', ':wa<CR>')

-- Allow copy pasting in WSL
vim.keymap.set({ 'v' }, '<F6>', '"*y<CR>')
vim.g.clipboard = {
  name = 'clipwsl',
  copy = {
    ["*"] = "/mnt/c/WINDOWS/system32/clip.exe",
  },
  paste = {
    ["*"] = "echo",
  },
  cache_enabled = false,
}

-- Make Y work like D and C
vim.keymap.set('n', 'Y', 'y$')

-- Make ; the same as :
vim.keymap.set('n', ';', ':')

-- Add toggle for highlight
vim.keymap.set('n', ',/', ':nohls<CR>', { silent = true })

vim.keymap.set('i', '<C-f>', require("copilot.suggestion").accept)

-- Add toggle for numbers
local toggle_numbers = function()
  if vim.o.number then
    vim.o.number = false
  else
    vim.o.number = true
  end
end

vim.keymap.set('n', ',l', toggle_numbers)

-- paste but don't replace paste buffer
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Stay in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Don't show this weird menu thing
vim.keymap.set("n", "Q", "<nop>")

-- Move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- search and replace word under cursor
vim.keymap.set("n", ",s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", ",s", [[y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]])

-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Neovim swapfile reload fix https://github.com/neovim/neovim/issues/2127#issuecomment-150954047
vim.cmd([[
augroup AutoSwap
    autocmd!
    autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

function! AS_HandleSwapfile (filename, swapname)
    " if swapfile is older than file itself, just get rid of it
    if getftime(v:swapname) < getftime(a:filename)
            call delete(v:swapname)
            let v:swapchoice = 'e'
    endif
endfunction
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END
]])

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').git_files({ show_untracked = true }) end,
  { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'javascript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

require('treesj').setup {}
require('treesitter-context').setup {}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

local format_lsp = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- let uncrusify format c files
      return client.name ~= 'clangd' and client.name ~= 'ccls'
    end,

    bufnr = bufnr
  })
end
-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>vds', require('telescope.builtin').lsp_document_symbols, '[V]iew [D]ocument [S]ymbols')
  nmap('<leader>vws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[V]iew [W]orkspace [S]ymbols')
  nmap(',f', format_lsp, '[F]ormat code')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', format_lsp, { desc = 'Format current buffer with LSP' })
end

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.sqlfmt,
    null_ls.builtins.formatting.uncrustify.with({
      extra_args = { '-c', '/usr/local/etc/citustools/citus-style.cfg' },
    }),
  },
})

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  on_attach(client, bufnr)
end)

lsp.extend_cmp()

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = { 'clangd', 'gopls', 'pyright', 'volar', 'html', 'tsserver', 'rust_analyzer', 'lua_ls' },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      -- (Optional) Configure lua language server for neovim
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    end,
    -- rust_analyzer = function()
    --   require('lspconfig').rust_analyzer.setup {
    --     cmd = { "ra-multiplex" },
    --   }
    -- end,
  },
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  preselect = require('cmp').PreselectMode.None,

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = "copilot",  group_index = 2 },
    { name = 'nvim_lsp', group_index = 2 },
    { name = 'luasnip',  group_index = 2 },
  },
}

-- Restore cursor position
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
            not (ft:match('commit') and ft:match('rebase'))
            and last_known_line > 1
            and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- require 'rainbow-delimiters'.setup{}
