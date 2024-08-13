return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local lualine_c = opts["sections"]["lualine_c"]
    lualine_c[#lualine_c - 1] = { LazyVim.lualine.pretty_path({ length = 0 }) }
    opts["length"] = 0
    return opts
  end,
}
