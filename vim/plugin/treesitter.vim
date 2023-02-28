if has('nvim')

lua << EOF

require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "all", -- one of "all" or a list of languages
  ensure_installed = {"c", "rust", "cpp", "python", "javascript" }, -- one of "all" or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {"vim", "perl"},  -- list of language that will be disabled
  },
}

EOF
endif
