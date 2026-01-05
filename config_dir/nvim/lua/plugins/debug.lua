return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
  -- stylua: ignore
  keys = {
    { "<leader>dE", function() require("dapui").eval() require("dapui").eval() end, desc = "Eval enter hover", mode = {"n", "v"} },
  },
  },
  {
    "mfussenegger/nvim-dap-python",
    enabled = false,
  },
}
