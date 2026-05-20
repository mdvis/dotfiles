#!/usr/bin/env bash

run_segment() {
    local wan_ip

    wan_ip=$(curl --max-time 2 -s https://whatismyip.akamai.com/)

    if [ -n "$wan_ip" ]; then
        echo "#[fg=colour255,bg=colour9] 󰖟 ${wan_ip} #[default]"
    fi

    return 0
}