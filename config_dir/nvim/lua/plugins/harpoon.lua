return {
  -- Harpoon plugin configuration
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
      local function toggle_telescope_with_harpoon(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = require("telescope.config").values.file_previewer({}),
            sorter = require("telescope.config").values.generic_sorter({}),
          })
          :find()
      end
      vim.keymap.set("n", "<leader>h", function()
        local harpoon = require("harpoon")
        toggle_telescope_with_harpoon(harpoon:list())
      end, { desc = "Open harpoon window" })
    end,
    keys = {
      -- {
      --   "<leader>A",
      --   function()
      --     require("harpoon"):list():append()
      --   end,
      --   desc = "harpoon file",
      -- },
      -- {
      --   "<C-b>",
      --   function()
      --     local harpoon = require("harpoon")
      --     harpoon.ui:toggle_quick_menu(harpoon:list())
      --   end,
      --   desc = "harpoon quick menu",
      -- },
    },
  },
}
