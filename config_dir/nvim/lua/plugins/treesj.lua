return {
  "Wansmer/treesj",
  keys = { "<leader>m", "<leader>j" },
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require("treesj").setup({})
  end,
}
