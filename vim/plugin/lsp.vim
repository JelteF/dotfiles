if has('nvim')


" Use <S-Tab> to navigate through autocompletion popup menu
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
"function! SuperTab()
"    if pumvisible()
"        return "\<C-n>"
"    elseif (strpart(getline('.'),col('.')-2,1)=~'^\s\?$')
"        return "\<Tab>"
"    else
"        set completeopt=menuone,longest,noselect
"        return "\<C-n>"
"    endif
"endfunction
"function! ResetCompleteOpt()
"    set completeopt=menuone,noinsert,noselect
"    return ''
"endfunction
"inoremap <Tab> <C-R>=SuperTab()<CR><C-R>=ResetCompleteOpt()<CR>



set completeopt=menuone,noinsert,noselect
" TextEdit might fail if hidden is not set.
"set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

lua << EOF

local cmp = require'cmp'
local nvim_lsp = require('lspconfig')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end


cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  completion = {
    autocomplete = false;
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- local map = function(type, key, value)
--     vim..nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
-- end
-- map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
-- map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
local on_attach = function(client, bufnr)
    -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end


    -- completion.on_attach(client, bufnr)
    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- -- Mappings.
    -- map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
    -- map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    -- map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
    -- map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    -- map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    -- map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    -- map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    -- map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    -- map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    -- map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    -- map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    -- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    -- map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
    -- map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    -- map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    -- map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')

    -- Set some keybinds conditional on server capabilities
    -- if client.resolved_capabilities.document_formatting then
    --   buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- end
    -- if client.resolved_capabilities.document_range_formatting then
    --   buf_set_keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    -- end

    -- vim.api.nvim_exec([[
    -- augroup lsp_line_diagnostics
    -- autocmd! * <buffer>
    -- autocmd CursorHold <buffer> lua vim.diagnostic.open_float()
    -- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    -- augroup END
    -- ]], false)

    -- Set autocommands conditional on server_capabilities
    -- if client.resolved_capabilities.document_highlight then
    -- vim.api.nvim_exec([[
    -- augroup lsp_document_highlight
    -- autocmd! * <buffer>
    -- autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    -- augroup END
    -- ]], false)
    -- end
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "gopls", "pyright", "ccls", "tsserver", "volar" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach, capabilities = capabilities }
end

nvim_lsp.ccls.setup {
    init_options = {
        cache = {
            directory = '/home/jelte/.ccls-cache'
        };
    },
    on_attach = on_attach,
    capabilities = capabilities,
}

local pid = vim.fn.getpid()
local omnisharp_bin = "/home/jelte/.omnisharp/run"
nvim_lsp.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.rust_analyzer.setup{
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    on_attach = on_attach,
    capabilities = capabilities,
}

EOF
endif
