return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              disabled = { "proc-macro-disabled" },
            },
          },
        },
      },
    },
  },
}
