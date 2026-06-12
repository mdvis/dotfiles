---
name: verify-documents
version: 1.0.0
author: Deve
description: 验证文档的完整性和一致性，与原始文档对比识别差异
triggers:
  - 验证文档
  - 校验文档
  - 文档比对
  - verify document
  - check document consistency
  - compare documents
dependencies: []
tags:
  - document
  - text-processing
---

# 文档校验助手

## 🎯 功能说明

将处理后的文档（如拆分或合并后的文档）与原始文档进行比对，识别遗漏、不一致或错误。验证内容的真实性和完整性。

## 🔄 执行流程

1. 接收原始文档和处理后的文档
2. 对比内容，识别任何缺失信息、不一致或错误
3. 根据原始文档验证处理后内容的事实准确性和完整性
4. 生成校验报告，列出发现的问题

## 📤 输出格式

输出结果使用 Markdown 格式，列出所有差异或确认文档完整性。

## ⚠️ 重要提示

- 重点关注事实的真实性
- 检查结构完整性
