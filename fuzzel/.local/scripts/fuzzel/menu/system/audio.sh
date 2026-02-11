#!/usr/bin/env bash

menu_dir_path=~/.local/scripts/fuzzel/menu
category_audio=$menu_dir_path/system/audio

# Options
declare -A ACTIONS=(
  [" Back"]="$HOME/.local/scripts/fuzzel/menu/menu.sh"
  ["  󱡬 Change default sink"]="bash '$menu_dir_path/system/audio/change_sink.sh'"
  ["  󱡬 Change default source"]="bash '$menu_dir_path/system/audio/change_source.sh'"
)
MENU_ORDER=(
  " Back"
  "  󱡬 Change default sink"
  "  󱡬 Change default source"
)

# Main
chosen=$(printf '%s\n' "${MENU_ORDER[@]}" | fuzzel -d -p " ")

[ -z "$chosen" ] && exit 0
eval "${ACTIONS[$chosen]}"
