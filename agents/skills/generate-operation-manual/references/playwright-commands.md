# Playwright CLI 命令参考

> 此文件供 `generate-operation-manual` Skill 使用，记录在操作手册生成场景中常用的 `playwright-cli` 命令。

## 1. 基本操作

```bash
# 打开页面
playwright-cli open <URL>

# 获取页面快照（返回含 ref 的 YAML，用于后续 fill/click）
playwright-cli snapshot

# 关闭浏览器
playwright-cli close
```

## 2. 登录流程

```bash
# 打开登录页
playwright-cli open http://<HOST>/user/login

# 快照获取元素 ref
playwright-cli snapshot
# 查看快照确认 ref（示例：e12 为用户名框，e13 为密码框，e14 为登录按钮）

# 填写用户名 / 密码
playwright-cli fill <username-ref> "name"
playwright-cli fill <password-ref> "pass"

# 点击登录
playwright-cli click <login-btn-ref>
```

> ⚠️ 登录后实际跳转 URL 不固定，无需等待特定 URL，直接 `goto` 目标页面即可。

## 3. 页面导航与等待

```bash
# 导航到目标页面
playwright-cli goto http://<HOST>/<PATH>

# SPA 页面等待渲染（至少 3 秒）
sleep 3

# layout:false 路由（表单设计器等）等待 5-6 秒
sleep 6
```

## 4. 数据提取 eval 命令

```bash
# 获取页面标题
playwright-cli eval "document.title"

# 获取页面关键文本（前 3000 字）
playwright-cli eval "() => document.body.innerText.substring(0, 3000)"

# 所有按钮文本
playwright-cli eval "() => [...document.querySelectorAll('button')].map(b => b.textContent?.trim() || b.getAttribute('aria-label') || '').filter(Boolean).join('|||')"

# Ant Design 表格列名
playwright-cli eval "() => [...document.querySelectorAll('.ant-table-thead th')].map(h => h.textContent?.trim()).filter(Boolean).join('|||')"

# 所有输入框 placeholder
playwright-cli eval "() => [...document.querySelectorAll('input:not([type=hidden])')].map(i => i.placeholder || i.getAttribute('aria-label') || '').filter(Boolean).join('|||')"

# 图表数量（canvas / svg）
playwright-cli eval "() => ({ canvas: document.querySelectorAll('canvas').length, svg: document.querySelectorAll('svg').length })"

# 下拉选择器标签
playwright-cli eval "() => [...document.querySelectorAll('.ant-select-selector')].map(s => s.textContent?.trim()).filter(Boolean).join('|||')"
```

## 5. 截图

```bash
# 确保截图目录存在
mkdir -p 操作手册图片

# 截图（路径相对于执行命令时的 cwd，需在项目根目录下执行）
playwright-cli screenshot --filename="操作手册图片/01-页面标题.png"
```

> ⚠️ `--filename` 是相对路径，需在项目根目录执行 `playwright-cli` 命令。

## 6. 截图命名规则

| 序号 | 格式 | 示例 |
|------|------|------|
| 01   | `01-页面标题.png` | `01-报告模板.png` |
| 02   | `02-页面标题.png` | `02-慢病管理.png` |
| ...  | ...              | ...              |

## 7. 常见异常处理

| 情况 | 处理方式 |
|------|----------|
| `document.title` 仍为 `"Gnosis"` | 增加 sleep 时间（3→5 秒）后重试 |
| `.ant-table-thead` 为空 | 卡片布局页面正常，直接跳过 |
| 页面显示 403 | 手册中标注「无权限访问」 |
| 页面 30 秒未渲染 | 标注「页面加载异常」并注明可能原因 |
| 按钮文本含 🌜🌞 | 主题切换按钮，忽略 |
