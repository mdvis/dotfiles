return {
  "mason-org/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
  opts = {
    ensure_installed = {
      "bashls",
      "eslint",
      "jsonls",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "ts_ls",
      "gopls",
      "marksman",
      "taplo",
      "yamlls",
    },
    -- automatic_enable = true,
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
  end,
}
