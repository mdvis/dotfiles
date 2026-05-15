return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- In v4, keymaps are configured via the 'keymaps' table at the top level
      -- The default keymaps are: ys, yss, yS, ySS (normal), S, gS (visual), ds, cs
      -- If you need custom keymaps, use vim.keymap.set() after setup
    })
  end,
}
