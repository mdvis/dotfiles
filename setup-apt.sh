#!/usr/bin/env bash

# ------
# name: setup-apt.sh
# author: Deve
# date: 2022-06-29
# ------

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"

echo "------------ apt start ------------"
while read -r line; do
    app=$(echo "$line" | xargs)
    [[ -z "$app" || "$app" =~ ^# ]] && continue
    sudo apt install -y "$app"
done <"${DOTFILES_PATH}/packages/apt"
echo "------------  apt end  ------------"
