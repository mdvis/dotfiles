#!/usr/bin/env bash

# ------
# name: setup-pacman.sh
# author: Deve
# date: 2026-06-30
# ------

set -e
set -o pipefail

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"

install_from_list() {
    local list_file="$1"
    local use_aur="${2:-false}"
    [[ ! -f "${list_file}" ]] && return
    
    local packages=()
    while read -r line; do
        app=$(echo "$line" | xargs)
        [[ -z "$app" || "$app" =~ ^# ]] && continue
        packages+=("$app")
    done <"${list_file}"
    
    if [[ ${#packages[@]} -eq 0 ]]; then
        return
    fi
    
    if [[ "$use_aur" == "true" ]]; then
        if command -v yay &>/dev/null; then
            yay -S --needed --noconfirm "${packages[@]}" || {
                echo "Warning: Some AUR packages failed to install"
            }
        else
            echo "Warning: yay not found, skipping AUR packages"
        fi
    else
        sudo pacman -S --needed --noconfirm "${packages[@]}" || {
            echo "Warning: Some packages failed to install"
        }
    fi
}

echo "------------ pacman start ------------"
install_from_list "${DOTFILES_PATH}/packages/pacman"
echo "------------  pacman end  ------------"

echo "------------ yay (AUR) start ------------"
install_from_list "${DOTFILES_PATH}/packages/yay" "true"
echo "------------  yay (AUR) end  ------------"
