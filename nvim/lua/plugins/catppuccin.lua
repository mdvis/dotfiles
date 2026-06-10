return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      background = { light = "latte", dark = "mocha" },
      transparent_background = false,
      integrations = {
        mini = true,
        native_lsp = { enabled = true },
      },
    })
    vim.cmd.colorscheme "catppuccin"
  end,
}
