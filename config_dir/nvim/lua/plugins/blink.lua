return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        list = {
          -- selection = "manual",
        },
        ghost_text = {
          enabled = true,
        },
      },
      keymap = {
        preset = "super-tab",
        ["<C-f>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_forward()
            else
              return cmp.select_next()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_backward()
            else
              return cmp.select_prev()
            end
          end,
          "fallback",
        },
        ["<CR>"] = {
          function(cmp)
            local completion_list = require("blink.cmp.completion.list")
            if completion_list.selected_item_idx == 1 then
              return false
            end

            return cmp.accept()
          end,
          "fallback",
        },
      },
    },
  },
}
