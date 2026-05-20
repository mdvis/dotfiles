#!/usr/bin/env bash

# ------
# name: setup-apt.sh
# author: Deve
# date: 2022-06-29
# ------

set -e
set -o pipefail

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"
APT_PACKAGES_FILE="${DOTFILES_PATH}/packages/apt"

if [[ ! -f "${APT_PACKAGES_FILE}" ]]; then
    echo "Warning: ${APT_PACKAGES_FILE} not found, skipping apt packages installation"
    exit 0
fi

echo "------------ apt start ------------"
while read -r line; do
    app=$(echo "$line" | xargs)
    [[ -z "$app" || "$app" =~ ^# ]] && continue
    sudo apt install -y "$app" || {
        echo "Warning: Failed to install ${app}"
    }
done <"${APT_PACKAGES_FILE}"
echo "------------  apt end  ------------"
