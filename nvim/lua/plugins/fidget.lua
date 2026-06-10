return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    -- Options related to LSP progress subsystem
    progress = {
      display = {
        render_limit = 16, -- How many LSP messages to show at once
        done_ttl = 3, -- How long a message should persist after completion
      },
    },
    -- Options related to notification subsystem
    notification = {
      window = {
        winblend = 0, -- Transparent background
      },
    },
  },
}
