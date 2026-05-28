#!/usr/bin/env bash

# ------
# name: setup-apt.sh
# author: Deve
# date: 2022-06-29
# ------

set -e
set -o pipefail

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"

install_from_list() {
    local list_file="$1"
    [[ ! -f "${list_file}" ]] && return
    while read -r line; do
        app=$(echo "$line" | xargs)
        [[ -z "$app" || "$app" =~ ^# ]] && continue
        sudo apt install -y "$app" || {
            echo "Warning: Failed to install ${app}"
        }
    done <"${list_file}"
}

echo "------------ apt start ------------"
install_from_list "${DOTFILES_PATH}/packages/apt"
install_from_list "${DOTFILES_PATH}/packages/sway"
echo "------------  apt end  ------------"
