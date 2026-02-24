#!/usr/bin/env bash

result=$(cliphist list | sed 's/^[0-9]*\t//' | fuzzel --dmenu --width 70 --prompt="󰅍  ")

if [ -n "$result" ]; then
    cliphist list | grep -m 1 "$result" | cliphist decode | wl-copy
fi
