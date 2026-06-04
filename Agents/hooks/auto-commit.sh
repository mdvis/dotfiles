#!/usr/bin/env bash

# ------
# name: auto-commit.sh
# author: Deve
# date: 2026-03-31
# ------

INPUT=$(cat)

# 解析 stop_hook_active，兼容 jq 可能不存在的情况
STOP_HOOK_ACTIVE="false"
if command -v jq >/dev/null 2>&1; then
  STOP_HOOK_ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // false' 2>/dev/null || echo "false")
else
  # jq 不可用时，使用 grep -E 简易判断（POSIX 兼容）
  if echo "$INPUT" | grep -Eq '"stop_hook_active"[[:space:]]*:[[:space:]]*true'; then
    STOP_HOOK_ACTIVE="true"
  fi
fi

# 防止无限循环：commit 后再次触发时直接放行
if [ "$STOP_HOOK_ACTIVE" = "true" ]; then
  exit 0
fi

# 检查是否有未提交的变更
cd "$CLAUDE_PROJECT_DIR" 2>/dev/null || {
  cat <<ERR
{"decision":"approve","reason":"项目目录不可用，放行"}
ERR
  exit 0
}

# 判断是否为 git 仓库，如果不是则直接退出
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo '{"decision":"approve","reason":"非 git 仓库，放行"}'
  exit 0
fi

# Block 计数器文件（按项目隔离）
PROJECT_HASH=$(echo "$CLAUDE_PROJECT_DIR" | md5sum 2>/dev/null | head -c8 || echo "$CLAUDE_PROJECT_DIR" | md5 2>/dev/null | head -c8 || echo "default")
BLOCK_COUNTER_FILE="/tmp/auto-commit-block-counter-${PROJECT_HASH}"

# 检查工作区是否有变更（含 submodule dirty 检测）
HAS_CHANGES=false
if ! git diff --quiet 2>/dev/null; then
  HAS_CHANGES=true
elif ! git diff --cached --quiet 2>/dev/null; then
  HAS_CHANGES=true
elif [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
  HAS_CHANGES=true
elif [ -f .gitmodules ] && ! git submodule foreach --recursive 'git diff --quiet 2>/dev/null' 2>/dev/null; then
  HAS_CHANGES=true
fi

if [ "$HAS_CHANGES" = "false" ]; then
  # 无变更，重置 block 计数器
  echo 0 > "$BLOCK_COUNTER_FILE" 2>/dev/null
  echo '{"decision":"approve","reason":"无未提交变更，放行"}'
  exit 0
fi

# 防止提交失败导致死循环：连续 block 超过阈值后放行
MAX_BLOCK_COUNT=3
BLOCK_COUNT=0
if [ -f "$BLOCK_COUNTER_FILE" ]; then
  BLOCK_COUNT=$(cat "$BLOCK_COUNTER_FILE" 2>/dev/null | head -1)
  BLOCK_COUNT=${BLOCK_COUNT:-0}
fi
BLOCK_COUNT=$((BLOCK_COUNT + 1))
echo "$BLOCK_COUNT" > "$BLOCK_COUNTER_FILE"

if [ "$BLOCK_COUNT" -gt "$MAX_BLOCK_COUNT" ]; then
  # 超过阈值，放行并重置计数器
  echo 0 > "$BLOCK_COUNTER_FILE"
  cat <<WARN
{"decision":"approve","reason":"连续阻止次数过多($BLOCK_COUNT)，可能提交失败，放行退出"}
WARN
  exit 0
fi

# 有未提交变更，阻止 Claude 停止，让它继续执行 commit
cat <<EOF
{"decision": "block", "reason": "检测到未提交的变更，请调用 ~git-commit-helper 技能提交更新。"}
EOF

