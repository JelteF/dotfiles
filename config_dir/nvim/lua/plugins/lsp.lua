return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders=true", -- Fixed: was just --function-arg-placeholders
            "--fallback-style=llvm",
          },
        },
      },
      gopls = {
        gofumpt = false,
      },
    },
  },
}
