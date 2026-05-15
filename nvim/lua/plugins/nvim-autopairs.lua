return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    check_ts = true, -- 启用 treesitter 集成
    ts_config = {
      lua = { "string" }, -- 在 lua 字符串中不自动配对
      javascript = { "template_string" }, -- 在 JS 模板字符串中不自动配对
      java = false, -- 禁用 java 的 treesitter 检查
    },
    disable_filetype = { "TelescopePrompt", "vim" },
    disable_in_macro = true, -- 在宏录制时禁用
    disable_in_visualblock = false, -- 在可视块模式下启用
    disable_in_replace_mode = true,
    ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
    enable_moveright = true,
    enable_afterquote = true, -- 在引号后添加括号
    enable_check_bracket_line = true, -- 检查括号是否在同一行
    enable_bracket_in_quote = true,
    enable_abbr = false, -- 触发缩写时禁用
    break_undo = true, -- 切换撤销序列
    check_comma = true,
    map_cr = true,
    map_bs = true, -- 映射退格键
    map_c_h = false, -- 映射 <c-h> 删除一对
    map_c_w = false, -- 映射 <c-w> 删除一对（如果可能）
    -- Fast wrap 功能：快速用括号包裹文本
    fast_wrap = {
      map = "<M-e>", -- Alt+e 触发快速包裹
      chars = { "{", "[", "(", '"', "'" },
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      offset = 0,
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
    },
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    -- 添加自定义规则
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    -- 为箭头函数添加空格: () => {}
    npairs.add_rules({
      Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript", "javascriptreact" })
        :use_regex(true)
        :set_end_pair_length(2),
    })

    -- Markdown 代码块
    npairs.add_rules({
      Rule("```", "```", { "markdown" })
        :with_move(cond.none())
        :with_pair(cond.none()),
    })
  end,
}
