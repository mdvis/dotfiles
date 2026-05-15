return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
  },
  opts = {},
}
