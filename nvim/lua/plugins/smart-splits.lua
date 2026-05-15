return {
  "mrjones2014/smart-splits.nvim",
  lazy = false, -- recommended to not lazy load for multiplexer integration
  opts = {
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = { "NvimTree", "neo-tree" },
    -- Default resize amount
    default_amount = 3,
    -- Behavior at edge: 'wrap' | 'split' | 'stop'
    at_edge = "wrap",
    -- Float window behavior: 'previous' | 'mux'
    float_win_behavior = "previous",
    -- Move cursor to same row when switching splits horizontally
    move_cursor_same_row = false,
    -- Cursor follows swapped buffers
    cursor_follows_swapped_bufs = false,
    -- Multiplexer integration (auto-detected: tmux, zellij, wezterm, kitty)
    multiplexer_integration = nil,
    -- Disable multiplexer nav when zoomed
    disable_multiplexer_nav_when_zoomed = true,
  },
  keys = {
    -- Resizing splits
    { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },
    
    -- Moving between splits
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
    { "<C-\\>", function() require("smart-splits").move_cursor_previous() end, desc = "Move to previous split" },
    
    -- Swapping buffers between windows
    { "<leader>wh", function() require("smart-splits").swap_buf_left() end, desc = "Swap buffer left" },
    { "<leader>wj", function() require("smart-splits").swap_buf_down() end, desc = "Swap buffer down" },
    { "<leader>wk", function() require("smart-splits").swap_buf_up() end, desc = "Swap buffer up" },
    { "<leader>wl", function() require("smart-splits").swap_buf_right() end, desc = "Swap buffer right" },
  },
}
