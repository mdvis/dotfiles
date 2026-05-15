return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
  lazy = false,
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
}
