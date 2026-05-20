#!/usr/bin/env bash

TMUX_POWERLINE_DIR_HOME=$(dirname "$0")
TMUX_POWERLINE_DIR_SEGMENTS="${TMUX_POWERLINE_DIR_HOME}/segements"
left=(hostname lanip wanip)
right=(session time)
output=""

if [[ "$1" = "left" ]]; then
    for segement in "${left[@]}"; do
        segementPath="${TMUX_POWERLINE_DIR_SEGMENTS}/${segement}.sh"
        # shellcheck source=/dev/null
        source "${segementPath}"
        output="${output}$(run_segment)"
        unset -f run_segment
    done
fi

if [[ "$1" = "right" ]]; then
    for segement in "${right[@]}"; do
        segementPath="${TMUX_POWERLINE_DIR_SEGMENTS}/${segement}.sh"
        # shellcheck source=/dev/null
        source "${segementPath}"
        output="${output}$(run_segment)"
        unset -f run_segment
    done
fi

echo "${output}"
exit 0