#!/usr/bin/env bash

# Options
declare -A ACTIONS=(
  [" Back"]="$HOME/.local/scripts/fuzzel/menu/menu.sh"
  ["  󰐥 Shutdown"]="systemctl poweroff"
  ["   Reboot"]="systemctl reboot"
  ["   BIOS Setup"]="systemctl reboot --firmware-setup"
)
MENU_ORDER=(
  " Back"
  "  󰐥 Shutdown"
  "   Reboot"
  "   BIOS Setup"
)

# Main
chosen=$(printf '%s\n' "${MENU_ORDER[@]}" | fuzzel -d -p "󰐥 ")

[ -z "$chosen" ] && exit 0
eval "${ACTIONS[$chosen]}"
