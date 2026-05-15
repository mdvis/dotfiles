return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = "diff2_horizontal",
      },
      merge_tool = {
        layout = "diff3_horizontal",
      },
    },
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch History" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  },
}
