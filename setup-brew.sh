#!/usr/bin/env bash

# ------
# name: setup-brew.sh
# author: Deve
# date: 2026-05-14
# ------

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"

echo "------------ brew start ------------"
brew bundle --file="${DOTFILES_PATH}/Brewfile"
echo "------------  brew end  ------------"
