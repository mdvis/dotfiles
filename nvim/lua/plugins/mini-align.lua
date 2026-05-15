return {
  "echasnovski/mini.align",
  lazy = false,  -- 立即加载，确保快捷键生效
  config = function()
    require("mini.align").setup({
      mappings = {
        start = "gA",           -- 开始对齐
        start_with_preview = "ga", -- 带预览的对齐（注意：可能与 neo-tree 的 ga 冲突）
      },
    })
  end,
}
