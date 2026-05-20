#! /usr/bin/env bash

set -e
set -o pipefail

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

handlerText() {
    local begin=0
    local ind=0
    scriptsLs=()
    
    while read -r line; do
        if [[ "${line}" =~ \} && "${begin}" == "1" ]]; then
            begin=0
        fi

        if [[ "${begin}" == "1" ]]; then
            local script_name=$(echo "${line}" | awk '{print $1}' | sed 's/"\(.*\)":/\1/')
            if [[ -n "${script_name}" ]]; then
                scriptsLs[ind]="${script_name}"
                ind=$((ind + 1))
            fi
        fi

        if [[ "${line}" =~ \"scripts\" ]]; then
            begin=1
        fi
    done <"$1"
}

function runCmd() {
    if [[ ${#scriptsLs[@]} -eq 0 ]]; then
        echo "No scripts found in package.json"
        return 1
    fi
    
    select m in "${scriptsLs[@]}"; do
        if [[ -n "$m" ]]; then
            [[ -f ".nvmrc" ]] && nvm use
            npm run "$m"
            break
        fi
    done
}

handleCmd() {
    [[ -f "./package.json" ]] || exit 1
    handlerText ./package.json
    runCmd
}

if ! handleCmd; then
    dir=$(find . -type d -name node_modules -prune -o -type d -print | fzf --prompt="Select directory: ")
    if [[ -n "$dir" ]]; then
        cd "$dir" && handleCmd
    fi
fi
