---
name: generate-operation-manual
version: 1.0.0
author: AI (agent_created)
description: 生成 Web 应用的中文图文操作手册，结合代码分析与 Playwright 自动化截图。
triggers:
  - 生成操作手册
  - 生成界面手册
  - 生成使用手册
  - generate operation manual
dependencies:
  - playwright-cli
tags:
  - documentation
  - automation
  - playwright
---

# 操作手册生成 Skill

## 🎯 功能说明

针对任意 Web 项目，输入「目标系统地址 + 登录凭据 + 页面路由列表」，自动完成：

1. 代码分析（读取路由配置、页面组件）
2. Playwright 逐页抓取截图与 UI 数据
3. 生成中文操作手册 Markdown 文件（`操作手册.md`）

## 🚀 触发场景

当用户提供以下信息并希望生成操作手册时触发：

- 系统地址（如 `http://192.168.50.161:93`）
- 登录凭据（如 `用户名 / 密码`）
- 任意个页面路由（如 `/sort-rule`、`/chronic-disease`）

## 📥 输入参数

如果用户没有全部提供，按以下顺序提问（每次只问缺失的部分，避免冗长）：

| 参数         | 说明                                      |
| ------------ | ----------------------------------------- |
| `BASE_URL`   | 系统根地址，如 `http://192.168.50.161:93` |
| `USERNAME`   | 登录用户名                                |
| `PASSWORD`   | 登录密码                                  |
| `PAGES`      | 目标页面路由列表（可多个，换行分隔）      |
| `OUTPUT_DIR` | 可选，手册输出目录，默认为当前工作目录    |

## 🔄 执行流程

新建一个以当前`日期_时分`为名称的目录，本次所有产物均放在新建的目录中(图片文档等)

### 第 1 步：代码分析

1. 读取项目 `config/routes.ts`（或 `src/routes.ts`），找到每条路由对应的页面组件路径
2. 读取各组件的 `index.tsx`，识别 UI 元素（按钮、表格、输入框、弹窗、卡片等）
3. 归纳每个页面的功能定位（配置页 / 列表页 / 详情页等）

### 第 2 步：Playwright 抓取页面

使用 `playwright-cli` 命令行工具。详细命令参见 `references/playwright-commands.md`。

#### 2.1 登录

```bash
playwright-cli open <BASE_URL>/user/login
playwright-cli snapshot            # 获取元素 ref
playwright-cli fill <username-ref> "<USERNAME>"
playwright-cli fill <password-ref> "<PASSWORD>"
playwright-cli click <login-btn-ref>
```

> 登录成功后跳转 URL 不固定，直接 `goto` 目标页面即可。

#### 2.2 逐页抓取

对每个目标页面执行（详细命令见 `references/playwright-commands.md`）：

```
goto → sleep → eval(title/buttons/inputs/table-headers/text) → screenshot
```

截图保存路径：`<OUTPUT_DIR>/操作手册图片/<序号>-<页面标题>.png`

#### 2.3 关闭浏览器

```bash
playwright-cli close
```

### 第 3 步：生成手册 Markdown

为每个页面生成以下结构：

```markdown
## <序号>. <页面标题>

**路由：** `<路由路径>`

<一句话说明页面用途>

![<页面标题>](操作手册图片/<序号>-<页面标题>.png)

### 界面元素

| 区域 | 元素 | 说明 |
| ---- | ---- | ---- |
| ...  | ...  | ...  |

### 操作步骤

1. ...
2. ...
```

末尾附「页面汇总表」（序号 / 路由 / 标题 / 说明）。

### 第 4 步：保存

- 手册写入 `<OUTPUT_DIR>/操作手册.md`
- 截图存放于 `<OUTPUT_DIR>/操作手册图片/`
- 确保 Markdown 中的截图引用为相对路径

## ⚠️ 注意事项

- SPA 页面初次加载后 `document.title` 可能仍为框架默认标题，需 sleep 3-5 秒后重试
- `layout: false` 的路由（表单设计器等）加载更慢，sleep 5-6 秒，标题可能始终为默认值
- `body.innerText` 会混入侧边栏菜单文本，属正常现象，手工过滤
- 页面显示 403 时，在手册中标注「无权限访问」
- 手册面向操作人员，全部使用自然语言，不写代码
- 内容必须基于实际抓取数据 + 代码分析的交叉验证，不得凭空编造

## 📚 参考资料

详细 Playwright 命令示例见 → `references/playwright-commands.md`
