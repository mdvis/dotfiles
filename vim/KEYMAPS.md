# Vim 快捷键清单

> Leader 键：`,`（逗号）

---

## 1. 通用快捷键

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| n | `,,t` | 插入文件模板 | `config/vimrc.maps` |
| n | `,,o` | 浏览最近文件 (oldfiles) | `config/vimrc.maps` |
| n | `,<CR>` | 清除搜索高亮 | `config/vimrc.maps` |
| n | `,r` | 显示寄存器 | `config/vimrc.maps` |
| n | `,h` | 跳到行首非空字符 (^) | `config/vimrc.maps` |
| n | `,l` | 跳到行尾非空字符 (g_) | `config/vimrc.maps` |
| n | `,cc` | 切换光标列高亮 | `config/vimrc.maps` |
| n | `,cl` | 刷新屏幕 (重绘/重置语法/清除搜索) | `config/vimrc.maps` |
| n | `j` | 按视觉行向下移动 (gj) | `config/vimrc.maps` |
| n | `k` | 按视觉行向上移动 (gk) | `config/vimrc.maps` |

---

## 2. 窗口导航

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| n | `<C-h>` | 移动到左边窗口 | `config/vimrc.maps` |
| n | `<C-j>` | 移动到下方窗口 | `config/vimrc.maps` |
| n | `<C-k>` | 移动到上方窗口 | `config/vimrc.maps` |
| n | `<C-l>` | 移动到右边窗口 | `config/vimrc.maps` |

---

## 3. 文件浏览 (NERDTree)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| n, v, s | `,e` | 定位当前文件 (NERDTreeFind) | `config/vimrc.maps` |
| n, v, s | `,n` | 切换 NERDTree | `config/vimrc.maps` |

---

## 4. 搜索 (FZF)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| n | `<C-p>` | 查找文件 (Files) | `config/vimrc.maps` |
| n | `,b` | 缓冲区列表 (Buffers) | `config/vimrc.maps` |
| n | `,R` | Ripgrep 搜索 (Rg) | `config/vimrc.maps` |

### FZF 内部键位

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `Ctrl-e` | 用 edit 打开 | `config/vimrc.plugins` |
| `Ctrl-t` | 用 tab split 打开 | `config/vimrc.plugins` |
| `Ctrl-x` | 用 split 打开 | `config/vimrc.plugins` |
| `Ctrl-v` | 用 vsplit 打开 | `config/vimrc.plugins` |

---

## 5. 代码导航 (Coc.nvim)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| n | `,cd` | 跳转到定义 | `config/vimrc.plugins` |
| n | `,cy` | 跳转到类型定义 | `config/vimrc.plugins` |
| n | `,ci` | 跳转到实现 | `config/vimrc.plugins` |
| n | `,cr` | 查看引用 | `config/vimrc.plugins` |
| n | `K` | 悬停文档 | `config/vimrc.plugins` |
| n | `,cn` | 重命名符号 | `config/vimrc.plugins` |
| n, x | `,cf` | 格式化选中区域 | `config/vimrc.plugins` |

---

## 6. 补全 (Coc.nvim)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| i | `<Tab>` | 智能补全导航 / delimitMate 跳转 / 原始 Tab | `config/vimrc.plugins` |
| i | `<S-Tab>` | 补全列表中上一个 | `config/vimrc.plugins` |
| i | `<CR>` | 确认补全 | `config/vimrc.plugins` |
| i | `<C-l>` | 展开代码片段 / 跳到下一个占位符 | `config/vimrc.plugins` |

---

## 7. Snippet (coc-snippets)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| i | `<C-j>` | 跳到下一个片段占位符 | `config/vimrc.plugins` |
| i | `<C-k>` | 跳到上一个片段占位符 | `config/vimrc.plugins` |

---

## 8. 代码检查 (ALE)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| n | `,ak` | 上一个错误/警告 | `config/vimrc.maps` |
| n | `,aj` | 下一个错误/警告 | `config/vimrc.maps` |

---

## 9. Git (Fugitive)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| n | `,gs` | 打开 Git 状态 (:G) | `config/vimrc.maps` |

---

## 10. 标签栏 (Tagbar)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| n | `,t` | 切换 Tagbar | `config/vimrc.maps` |

---

## 11. 撤销树 (Undotree)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| n | `,u` | 切换 Undotree | `config/vimrc.maps` |

---

## 12. 对齐 (vim-easy-align)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| n | `ga` | 启动对齐 | `config/vimrc.maps` |
| x | `ga` | 对齐选中区域 | `config/vimrc.maps` |

---

## 13. AI 辅助 (Augment)

| 模式 | 快捷键 | 功能 | 来源 |
|------|--------|------|------|
| i | `,y` | 接受 Augment 建议 | `config/vimrc.maps` |

---

## 14. 注释 (vim-commentary)

> 默认键位

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `gcc` | 注释/取消注释当前行 |
| n | `gc{motion}` | 注释/取消注释 (操作符) |
| x | `gc` | 注释/取消注释选中区域 |

---

## 15. 包围 (vim-surround)

> 默认键位

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `ys{motion}{char}` | 添加包围 |
| n | `yss{char}` | 包围整行 |
| n | `ds{char}` | 删除包围 |
| n | `cs{old}{new}` | 修改包围 |
| x | `S{char}` | 可视模式添加包围 |

---

## 16. 用户命令

| 命令 | 功能 | 来源 |
|------|------|------|
| `:SetTpl` | 插入文件模板 | `config/vimrc.custom` |
| `:EConf` | 编辑配置文件 | `config/vimrc.custom` |
| `:SConf` | 重新加载配置文件 | `config/vimrc.custom` |
| `:W` | 以 sudo 保存文件 | `config/vimrc.custom` |
| `:Rg {pattern}` | 使用 fzf + ripgrep 搜索 | `config/vimrc.custom` |

---

## Leader 键速查

| 前缀 | 分类 |
|------|------|
| `,c` | Coc 代码相关 |
| `,a` | ALE / Harpoon |
| `,g` | Git |
| `,f` | 格式化 |
| `,b` | 缓冲区 |
| `,e` | NERDTree 定位 |
| `,n` | NERDTree 切换 |
| `,t` | Tagbar |
| `,u` | Undotree |
| `,r` | 寄存器 |
| `,h` / `,l` | 行首/行尾 |
| `,cc` | 光标列切换 |
| `,cl` | 屏幕刷新 |
