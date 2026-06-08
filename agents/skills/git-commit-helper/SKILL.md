---
name: git-commit-helper
description: 根据 git diff 生成符合 Conventional Commits 规范的提交信息
triggers:
  - 提交
  - commit
version: 1.0.0
author: einverne
---

# Git 提交信息生成助手

## 功能说明

分析 git 暂存区的代码变动，生成符合 Conventional Commits 规范的提交信息。

## Conventional Commits 规范

提交信息格式：`<type>(<scope>): <subject>`

类型（type）：

- feat: 新功能
- fix: 修复 bug
- docs: 文档更新
- style: 代码格式调整
- refactor: 重构代码
- perf: 性能优化
- test: 测试相关
- chore: 构建工具或辅助工具的变动

## 执行流程

1. 执行 `git diff` 查看暂存区变更
2. 分析变更内容的目的，将不同目的的内容（一次内容尽量少）分多次提交
3. 分析变更内容，识别修改类型和影响范围

- 确定合适的 type 和 scope
- 生成简洁明了的 subject
- 如有必要，添加详细的 body 和 footer

4. 提交按照 ‘type(scope):subject‘ 格式来
5. 所以内容均使用汉语

## 输出格式

```
type(scope):subject

[可选的详细说明]

[可选的 footer，如 BREAKING CHANGE、关闭的 issue]
```

## 质量标准

- 严格遵守 SPR 原则
- subject 使用动词开头，不超过 50 个字符
- subject 不以句号结尾
- body 每行不超过 72 个字符
- 使用中文，保持一致
- 每个提交都聚焦单一目的，更符合 Conventional Commits 最佳实践
- 严格遵守: 不要添加智能助手的签名;不要有 Co-Authored-By
