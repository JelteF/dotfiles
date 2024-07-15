return {
  "gbprod/yanky.nvim",
  opts = function()
    local utils = require("yanky.utils")
    local mapping = require("yanky.telescope.mapping")
    return {
      picker = {
        telescope = {
          use_default_keymaps = false,
          mappings = {
            default = mapping.put("p"),
            i = {
              ["<C-CR>"] = mapping.put("P"),
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-x>"] = mapping.delete(),
              ["<C-r>"] = mapping.set_register(utils.get_default_register()),
            },
            n = {
              p = mapping.put("p"),
              P = mapping.put("P"),
              d = mapping.delete(),
              r = mapping.set_register(utils.get_default_register()),
            },
          },
        },
      },
    }
  end,
}
