return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", "/home/jelte/dotfiles/config_dir/nvim/.markdownlint-cli2.yaml", "--" },
        },
      },
    },
  },
}
