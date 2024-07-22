return {
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      {
        "<leader>fP",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<C-p>",
        function()
          require("telescope.builtin").git_files({ show_untracked = true })
        end,
        { desc = "Search [G]it [F]iles" },
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").lsp_references()
        end,
        desc = "Find references (telescope)",
      },
    },
    -- change some options
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
    },
  },
}
