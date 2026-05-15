return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {
    -- 启用渲染
    enabled = true,
    -- 在普通、命令和终端模式下渲染
    render_modes = { "n", "c", "t" },
    -- 最大文件大小限制 (MB)
    max_file_size = 10.0,

    -- 标题配置
    heading = {
      enabled = true,
      sign = true,
      position = "overlay",
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      width = "full",
      border = false,
      left_pad = 0,
      right_pad = 0,
    },

    -- 代码块配置
    code = {
      enabled = true,
      sign = true,
      style = "full",
      position = "left",
      language_icon = true,
      language_name = true,
      width = "full",
      left_pad = 1,
      right_pad = 1,
      border = "thin",
      above = "▄",
      below = "▀",
    },

    -- 列表项配置
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
      left_pad = 0,
      right_pad = 1,
    },

    -- 复选框配置
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
      },
    },

    -- 引用块配置
    quote = {
      enabled = true,
      icon = "▋",
      repeat_linebreak = false,
    },

    -- 表格配置
    pipe_table = {
      enabled = true,
      preset = "none",
      style = "full",
      cell = "padded",
      padding = 1,
      border = {
        "┌", "┬", "┐",
        "├", "┼", "┤",
        "└", "┴", "┘",
        "│", "─",
      },
    },

    -- Callout 配置 (支持 GitHub 和 Obsidian 风格)
    callout = {
      note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
      tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
      important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
      warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
      caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
    },

    -- 链接配置
    link = {
      enabled = true,
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      custom = {
        web = { pattern = "^http", icon = "󰖟 " },
        github = { pattern = "github%.com", icon = "󰊤 " },
      },
    },

    -- 分隔线配置
    dash = {
      enabled = true,
      icon = "─",
      width = "full",
    },

    -- LaTeX 支持
    latex = {
      enabled = true,
      converter = "latex2text",
      highlight = "RenderMarkdownMath",
    },

    -- 反隐藏配置 (光标所在行显示原始内容)
    anti_conceal = {
      enabled = true,
      above = 0,
      below = 0,
    },

    -- 窗口选项
    win_options = {
      conceallevel = {
        default = vim.api.nvim_get_option_value("conceallevel", {}),
        rendered = 3,
      },
      concealcursor = {
        default = vim.api.nvim_get_option_value("concealcursor", {}),
        rendered = "",
      },
    },
  },
}
