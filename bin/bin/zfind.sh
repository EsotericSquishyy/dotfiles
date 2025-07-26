#!/usr/bin/env bash

file=$(find . -iname "*.pdf" -not -path '*/\.*' | fzf)

if [ -n "$file" ]; then
    nohup zathura "$file" >/dev/null 2>&1 &
fi
