return {
  "mason-org/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
  build = ":MasonUpdate",
  opts = {
    ui = {
      border = "rounded",
      width = 0.8,
      height = 0.8,
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
    max_concurrent_installers = 4,
  },
}
