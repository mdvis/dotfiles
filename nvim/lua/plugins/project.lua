return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Projects" },
  },
  config = function()
    require("project_nvim").setup({
      -- 检测方法
      detection_methods = { "lsp", "pattern" },
      -- 检测模式（用于检测项目根目录）
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        "pom.xml",
        "Cargo.toml",
        "go.mod",
        "pyproject.toml",
        "setup.py",
      },
      -- 忽略的 LSP 服务器
      ignore_lsp = {},
      -- 排除目录
      exclude_dirs = {},
      -- 显示隐藏文件
      show_hidden = false,
      -- 静默切换目录
      silent_chdir = true,
      -- 切换目录的范围
      scope_chdir = "global",
      -- 数据路径
      datapath = vim.fn.stdpath("data"),
    })

    -- 与 Telescope 集成
    pcall(function()
      require("telescope").load_extension("projects")
    end)
  end,
}
