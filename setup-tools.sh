#!/usr/bin/env bash

# ------
# name: setup-tools.sh
# desc: link scripts in tools/ to ~/.local/bin
# ------

install_tools() {
    local tools_path="${DOTFILES_PATH}/tools"
    local bin_path="${LOCAL_BIN_PATH}"

    mkdir -p "${bin_path}"

    for script in "${tools_path}"/*.sh; do
        [ -f "${script}" ] || continue
        local name
        name=$(basename "${script}" .sh)
        local target="${bin_path}${name}"
        backup "${target}"
        ln -sf "${script}" "${target}"
        success "Link tool: ${name}!"
    done
}

install_tools
