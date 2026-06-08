---
name: merge-documents
description: 将多个文档合并为一个完整文档
triggers:
  - 合并
  - 合并文档
  - 合并文章
  - 合并多个文档
  - 合并多个文章
  - merge documents
  - merge multiple documents
version: 1.0.1
author: Deve
---

# 文档合并助手

## 功能说明

将多个文档合并为一个连贯、完整的文档。

## 执行流程

1. 收集所有需要合并的文档
2. 按逻辑顺序合并为一个文档，确保格式一致
3. 将合并后的文档保存到磁盘

## 输出格式

输出结果使用 Markdown 格式。

## 重要提示

- 保持输入文档的原始顺序
- 确保格式一致性（标题层级、字体等）
- 合并完成后可使用 verify-documents 技能校验完整性