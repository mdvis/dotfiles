return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local luasnip = require("luasnip")

    -- 加载 VSCode 格式的代码片段
    require("luasnip.loaders.from_vscode").lazy_load()

    -- 配置选项
    luasnip.config.set_config({
      history = true, -- 记住上一个片段位置，可以跳回
      updateevents = "TextChanged,TextChangedI", -- 实时更新片段内容
      enable_autosnippets = true, -- 启用自动触发的片段
      store_selection_keys = "<Tab>", -- 存储可视模式选择的文本
    })

    -- 键位映射
    vim.keymap.set({ "i", "s" }, "<M-j>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true, desc = "展开或跳转到下一个片段位置" })

    vim.keymap.set({ "i", "s" }, "<M-k>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true, desc = "跳转到上一个片段位置" })

    vim.keymap.set("i", "<M-l>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true, desc = "切换片段选项" })
  end,
}
