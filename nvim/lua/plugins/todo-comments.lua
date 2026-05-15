return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TodoTrouble", "TodoTelescope", "TodoQuickFix", "TodoLocList" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search todos" },
    { "<leader>sT", "<cmd>TodoTrouble<cr>", desc = "Todos (Trouble)" },
  },
  opts = {
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    highlight = {
      before = "",
      keyword = "wide",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      pattern = [[\b(KEYWORDS):]],
    },
  },
}
