return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "gofmt" },
        json = { "biome-check", lsp_format = "fallback" },
        jsonc = { "biome-check", lsp_format = "fallback" },
      },
    },
  },
}
