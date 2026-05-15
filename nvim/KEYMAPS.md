# Neovim 快捷键清单

> Leader 键：`,`（逗号）

---

## 1. 通用快捷键

| 模式 | 快捷键  | 功能                  | 来源                 |
| ---- | ------- | --------------------- | -------------------- |
| n    | `,,t`   | 插入文件模板          | `config/keymaps.lua` |
| n    | `,<CR>` | 清除搜索高亮          | `config/keymaps.lua` |
| n    | `j`     | 按视觉行向下移动 (gj) | `config/keymaps.lua` |
| n    | `k`     | 按视觉行向上移动 (gk) | `config/keymaps.lua` |
| n    | `0`     | 跳到行首非空字符 (^)  | `config/keymaps.lua` |

---

## 2. 窗口与分屏 (smart-splits)

| 模式 | 快捷键  | 功能                   | 来源                       |
| ---- | ------- | ---------------------- | -------------------------- |
| n    | `<C-h>` | 移动到左边分屏         | `plugins/smart-splits.lua` |
| n    | `<C-j>` | 移动到下方分屏         | `plugins/smart-splits.lua` |
| n    | `<C-k>` | 移动到上方分屏         | `plugins/smart-splits.lua` |
| n    | `<C-l>` | 移动到右边分屏         | `plugins/smart-splits.lua` |
| n    | `<C-\>` | 移动到上一个分屏       | `plugins/smart-splits.lua` |
| n    | `<A-h>` | 向左调整分屏大小       | `plugins/smart-splits.lua` |
| n    | `<A-j>` | 向下调整分屏大小       | `plugins/smart-splits.lua` |
| n    | `<A-k>` | 向上调整分屏大小       | `plugins/smart-splits.lua` |
| n    | `<A-l>` | 向右调整分屏大小       | `plugins/smart-splits.lua` |
| n    | `,wh`   | 将缓冲区与左边窗口交换 | `plugins/smart-splits.lua` |
| n    | `,wj`   | 将缓冲区与下方窗口交换 | `plugins/smart-splits.lua` |
| n    | `,wk`   | 将缓冲区与上方窗口交换 | `plugins/smart-splits.lua` |
| n    | `,wl`   | 将缓冲区与右边窗口交换 | `plugins/smart-splits.lua` |

---

## 3. LSP (nvim-lspconfig)

> 以下快捷键仅在 LSP 附加到缓冲区时生效（buffer-local）

| 模式 | 快捷键 | 功能                     | 来源                         |
| ---- | ------ | ------------------------ | ---------------------------- |
| n    | `gd`   | 跳转到定义               | `plugins/nvim-lspconfig.lua` |
| n    | `gD`   | 跳转到声明               | `plugins/nvim-lspconfig.lua` |
| n    | `gi`   | 跳转到实现               | `plugins/nvim-lspconfig.lua` |
| n    | `gt`   | 跳转到类型定义           | `plugins/nvim-lspconfig.lua` |
| n    | `gr`   | 查看引用                 | `plugins/nvim-lspconfig.lua` |
| n    | `K`    | 悬停文档                 | `plugins/nvim-lspconfig.lua` |
| n    | `,ck`  | 签名帮助                 | `plugins/nvim-lspconfig.lua` |
| n, v | `,ca`  | 代码操作                 | `plugins/nvim-lspconfig.lua` |
| n    | `,cr`  | 重命名符号               | `plugins/nvim-lspconfig.lua` |
| n    | `[d`   | 上一个诊断               | `plugins/nvim-lspconfig.lua` |
| n    | `]d`   | 下一个诊断               | `plugins/nvim-lspconfig.lua` |
| n    | `,d`   | 显示诊断浮窗             | `plugins/nvim-lspconfig.lua` |
| n    | `,q`   | 诊断列表 (location list) | `plugins/nvim-lspconfig.lua` |
| n    | `,f`   | 格式化缓冲区 (conform)   | `plugins/nvim-lspconfig.lua` |
| n    | `,lwa` | 添加 workspace 文件夹    | `plugins/nvim-lspconfig.lua` |
| n    | `,lwr` | 移除 workspace 文件夹    | `plugins/nvim-lspconfig.lua` |
| n    | `,lwl` | 列出 workspace 文件夹    | `plugins/nvim-lspconfig.lua` |

---

## 4. 补全 (blink.cmp)

> 使用 `super-tab` 预设，集成 LuaSnip

| 模式 | 快捷键    | 功能                          | 来源                    |
| ---- | --------- | ----------------------------- | ----------------------- |
| i    | `<Tab>`   | 选择下一个补全 / 展开 snippet | `plugins/blink-cmp.lua` |
| i    | `<S-Tab>` | 选择上一个补全                | `plugins/blink-cmp.lua` |
| i    | `<CR>`    | 确认补全                      | `plugins/blink-cmp.lua` |

---

## 5. Snippet (LuaSnip)

| 模式 | 快捷键  | 功能                     | 来源                  |
| ---- | ------- | ------------------------ | --------------------- |
| i, s | `<M-j>` | 展开或跳到下一个片段位置 | `plugins/luasnip.lua` |
| i, s | `<M-k>` | 跳到上一个片段位置       | `plugins/luasnip.lua` |
| i    | `<M-l>` | 切换片段选项             | `plugins/luasnip.lua` |

---

## 6. 搜索 (Telescope)

### 加载触发键

| 模式 | 快捷键  | 功能                 | 来源                        |
| ---- | ------- | -------------------- | --------------------------- |
| n    | `<C-p>` | 查找文件             | `plugins/telescope.lua`     |
| n    | `,ff`   | 查找文件             | `plugins/telescope.lua`     |
| n    | `,fg`   | 实时搜索 (live_grep) | `plugins/telescope.lua`     |
| n    | `,fh`   | 帮助标签             | `plugins/telescope.lua`     |
| n    | `,fb`   | 缓冲区列表           | `plugins/telescope.lua`     |
| n    | `,fe`   | Emoji 搜索           | `plugins/telescope.lua`     |
| n    | `,fo`   | 历史文件             | `plugins/telescope.lua`     |
| n    | `,fp`   | 查找项目             | `plugins/project.lua`       |
| n    | `,st`   | 搜索 TODO 注释       | `plugins/todo-comments.lua` |
| n    | `,sT`   | TODO 列表 (Trouble)  | `plugins/todo-comments.lua` |

### Telescope 内部键位

| 模式 | 快捷键  | 功能           | 来源                    |
| ---- | ------- | -------------- | ----------------------- |
| i    | `<C-j>` | 下一个选项     | `plugins/telescope.lua` |
| i    | `<C-k>` | 上一个选项     | `plugins/telescope.lua` |
| i    | `<Esc>` | 关闭 Telescope | `plugins/telescope.lua` |

---

## 7. 文件浏览 (Oil)

| 模式 | 快捷键 | 功能       | 来源              |
| ---- | ------ | ---------- | ----------------- |
| n    | `-`    | 打开父目录 | `plugins/oil.lua` |

---

## 8. 符号大纲 (Outline)

| 模式 | 快捷键 | 功能             | 来源                          |
| ---- | ------ | ---------------- | ----------------------------- |
| n    | `,so`  | 切换符号大纲面板 | `plugins/symbols-outline.lua` |

### 大纲面板内部键位

| 快捷键        | 功能       |
| ------------- | ---------- |
| `<Esc>` / `q` | 关闭大纲   |
| `<CR>`        | 跳转到位置 |
| `o`           | 预览位置   |
| `<S-CR>`      | 跳转并关闭 |
| `<C-g>`       | 恢复位置   |
| `<C-space>`   | 悬停符号   |
| `K`           | 切换预览   |
| `r`           | 重命名符号 |
| `a`           | 代码操作   |
| `h`           | 折叠       |
| `l`           | 展开       |
| `W`           | 全部折叠   |
| `E`           | 全部展开   |
| `R`           | 重置折叠   |
| `<C-j>`       | 向下跳转   |
| `<C-k>`       | 向上跳转   |

---

## 9. Git

### Gitsigns

| 模式 | 快捷键 | 功能            | 来源                   |
| ---- | ------ | --------------- | ---------------------- |
| n    | `]c`   | 下一个 Git 改动 | `plugins/gitsigns.lua` |
| n    | `[c`   | 上一个 Git 改动 | `plugins/gitsigns.lua` |

### Diffview

| 模式 | 快捷键 | 功能          | 来源                   |
| ---- | ------ | ------------- | ---------------------- |
| n    | `,gd`  | 打开 Diffview | `plugins/diffview.lua` |
| n    | `,gh`  | 当前文件历史  | `plugins/diffview.lua` |
| n    | `,gH`  | 分支历史      | `plugins/diffview.lua` |
| n    | `,gc`  | 关闭 Diffview | `plugins/diffview.lua` |

### Neogit

| 模式 | 快捷键 | 功能        | 来源                 |
| ---- | ------ | ----------- | -------------------- |
| n    | `,gg`  | 打开 Neogit | `plugins/neogit.lua` |

---

## 10. TODO 注释 (todo-comments)

| 模式 | 快捷键 | 功能                  | 来源                        |
| ---- | ------ | --------------------- | --------------------------- |
| n    | `]t`   | 下一个 TODO 注释      | `plugins/todo-comments.lua` |
| n    | `[t`   | 上一个 TODO 注释      | `plugins/todo-comments.lua` |
| n    | `,st`  | 搜索 TODO (Telescope) | `plugins/todo-comments.lua` |
| n    | `,sT`  | TODO 列表 (Trouble)   | `plugins/todo-comments.lua` |

---

## 11. 诊断与问题列表 (Trouble)

| 模式 | 快捷键 | 功能               | 来源                  |
| ---- | ------ | ------------------ | --------------------- |
| n    | `,xx`  | 切换诊断列表       | `plugins/trouble.lua` |
| n    | `,xX`  | 切换当前缓冲区诊断 | `plugins/trouble.lua` |
| n    | `,cs`  | 切换符号列表       | `plugins/trouble.lua` |
| n    | `,cl`  | 切换 LSP 定义/引用 | `plugins/trouble.lua` |
| n    | `,xL`  | 切换 Location List | `plugins/trouble.lua` |
| n    | `,xQ`  | 切换 Quickfix List | `plugins/trouble.lua` |

---

## 12. Harpoon

| 模式 | 快捷键  | 功能               | 来源                  |
| ---- | ------- | ------------------ | --------------------- |
| n    | `,a`    | 添加文件到 Harpoon | `plugins/harpoon.lua` |
| n    | `<C-e>` | 切换 Harpoon 菜单  | `plugins/harpoon.lua` |

---

## 13. Flash (快速跳转)

| 模式    | 快捷键 | 功能                  | 来源                |
| ------- | ------ | --------------------- | ------------------- |
| n, x, o | `s`    | Flash 跳转            | `plugins/flash.lua` |
| n, x, o | `S`    | Flash Treesitter 选择 | `plugins/flash.lua` |
| o       | `r`    | 远程 Flash            | `plugins/flash.lua` |
| o, x    | `R`    | Treesitter 搜索       | `plugins/flash.lua` |

---

## 14. 折叠 (nvim-ufo)

| 模式 | 快捷键 | 功能         | 来源                   |
| ---- | ------ | ------------ | ---------------------- |
| n    | `zR`   | 打开所有折叠 | `plugins/nvim-ufo.lua` |
| n    | `zM`   | 关闭所有折叠 | `plugins/nvim-ufo.lua` |

---

## 15. 对齐 (mini.align)

| 模式 | 快捷键 | 功能               | 来源                     |
| ---- | ------ | ------------------ | ------------------------ |
| n, x | `ga`   | 带预览的对齐       | `plugins/mini-align.lua` |
| n, x | `gA`   | 开始对齐（无预览） | `plugins/mini-align.lua` |

---

## 16. 包围 (nvim-surround)

> 默认键位，无需额外配置

| 模式 | 快捷键             | 功能             | 来源                        |
| ---- | ------------------ | ---------------- | --------------------------- |
| n    | `ys{motion}{char}` | 添加包围         | `plugins/nvim-surround.lua` |
| n    | `yss{char}`        | 包围整行         | `plugins/nvim-surround.lua` |
| n    | `ds{char}`         | 删除包围         | `plugins/nvim-surround.lua` |
| n    | `cs{old}{new}`     | 修改包围         | `plugins/nvim-surround.lua` |
| x    | `S{char}`          | 可视模式添加包围 | `plugins/nvim-surround.lua` |

---

## 17. 多光标 (vim-visual-multi)

| 模式 | 快捷键     | 功能          | 来源                           |
| ---- | ---------- | ------------- | ------------------------------ |
| n, x | `<C-n>`    | 开始/添加光标 | `plugins/vim-visual-multi.lua` |
| n, x | `<C-Down>` | 向下添加光标  | `plugins/vim-visual-multi.lua` |
| n, x | `<C-Up>`   | 向上添加光标  | `plugins/vim-visual-multi.lua` |

---

## 18. 自动配对 (nvim-autopairs)

| 模式 | 快捷键  | 功能                 | 来源                         |
| ---- | ------- | -------------------- | ---------------------------- |
| i    | `<M-e>` | 快速包裹 (fast wrap) | `plugins/nvim-autopairs.lua` |

---

## 19. 注释 (Comment.nvim)

> 默认键位

| 模式 | 快捷键       | 功能                   |
| ---- | ------------ | ---------------------- |
| n    | `gcc`        | 注释/取消注释当前行    |
| n    | `gc{motion}` | 注释/取消注释 (操作符) |
| x    | `gc`         | 注释/取消注释选中区域  |

---

## 20. 消息与通知 (Noice)

| 模式    | 快捷键  | 功能             | 来源                |
| ------- | ------- | ---------------- | ------------------- |
| n       | `,nl`   | 查看最后一条消息 | `plugins/noice.lua` |
| n       | `,nh`   | 消息历史         | `plugins/noice.lua` |
| n       | `,na`   | 所有消息         | `plugins/noice.lua` |
| n       | `,nd`   | 关闭所有通知     | `plugins/noice.lua` |
| i, n, s | `<C-f>` | 向前滚动浮动文档 | `plugins/noice.lua` |
| i, n, s | `<C-b>` | 向后滚动浮动文档 | `plugins/noice.lua` |

---

## 21. 用户命令

| 命令      | 功能             | 来源                  |
| --------- | ---------------- | --------------------- |
| `:SetTpl` | 插入文件模板     | `config/autocmds.lua` |
| `:EConf`  | 编辑配置文件     | `config/autocmds.lua` |
| `:SConf`  | 重新加载配置文件 | `config/autocmds.lua` |

---

## Leader 键速查

| 前缀  | 分类                |
| ----- | ------------------- |
| `,f`  | 搜索/查找 (Find)    |
| `,g`  | Git 相关            |
| `,c`  | 代码/LSP (Code)     |
| `,s`  | 符号/搜索 (Symbol)  |
| `,x`  | 诊断/问题 (Trouble) |
| `,l`  | LSP Workspace       |
| `,w`  | 窗口交换            |
| `,n`  | Noice 通知          |
| `,d`  | 诊断浮窗            |
| `,q`  | 诊断列表            |
| `,a`  | Harpoon 添加        |
| `,ck` | 签名帮助            |
