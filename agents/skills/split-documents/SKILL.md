---
name: split-documents
version: 1.0.1
author: Deve
description: 将大文档拆分为多个小文档
triggers:
  - 拆分文档
  - 拆分文章
  - divide document
dependencies: []
tags:
  - document
  - text-processing
---

# 文档拆分助手

## 🎯 功能说明

将大型文档按逻辑章节或结构拆分为多个较小的文档。

## 🔄 执行流程

1. 分析原始文档的内容和结构
2. 根据章节、段落或用户指定的标准将文档拆分为多个小文档
3. 确保每个拆分部分尽可能保持上下文完整
4. 将拆分后的文档保存到磁盘

## 📤 输出格式

输出结果使用 Markdown 格式。

## ⚠️ 重要提示

- 保持逻辑连贯性
- 确保拆分过程中不丢失任何内容（可使用 verify-documents 技能进行校验）