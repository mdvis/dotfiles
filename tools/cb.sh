#! /usr/bin/env bash

function changeBranch() {
    branchName="$(git branch -a | fzf)"
    git checkout "${branchName##* }"
}

if [ -d "./.git" ]; then
    changeBranch
else
    echo "No repository!"
fi
