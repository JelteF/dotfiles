return {
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>j", "", desc = "+treesj", mode = { "n" } },
      {
        "<leader>jm",
        function()
          require("treesj").toggle()
        end,
        desc = "Split or Join code block with autodetect",
      },
      {
        "<leader>jj",
        function()
          require("treesj").join()
        end,
        desc = "Join code block",
      },
      {
        "<leader>js",
        function()
          require("treesj").split()
        end,
        desc = "Split code block",
      },
      {
        "<leader>jM",
        function()
          require("treesj").toggle({
            recursive = true,
          })
        end,
        desc = "Split or Join code block with autodetect recursively",
      },
      {
        "<leader>jJ",
        function()
          require("treesj").join({ recursive = true })
        end,
        desc = "Join code block recursively",
      },
      {
        "<leader>jS",
        function()
          require("treesj").split({ recursive = true })
        end,
        desc = "Split code block recursively",
      },
    },
    use_default_keymaps = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require("treesj").setup({})
    end,
  },
}
