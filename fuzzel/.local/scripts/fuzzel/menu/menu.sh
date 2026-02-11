#!/usr/bin/env bash

# 1. Checking DND
if [ "$(dunstctl is-paused)" == "true" ]; then
    dunst_icon="󰂛"
else
    dunst_icon="󰂚"
fi

# Paths
menu_dir_path=~/.local/scripts/fuzzel/menu
category_sys=$menu_dir_path/system
category_cfgs=$menu_dir_path/configs

# Options
declare -A ACTIONS=(
  ["󰣇 System"]="exec '$0'"
  ["  󰐥 Power Menu"]="bash '$category_sys/power.sh'"
  ["  󰚰 Update"]="bash '$category_sys/update.sh'"
  ["  $dunst_icon Do Not Disturb"]="bash '$category_sys/dnd.sh' && exec '$0'"
  ["   Audio"]="bash '$category_sys/audio.sh'"
  ["  󰖩 Network"]="bash '$category_sys/network.sh'"
  [" Configs"]="exec '$0'"
  ["   Open ~/.dotfiles"]="bash '$category_cfgs/dotfiles.sh'"
  ["  󰏫 Edit Niri"]="bash '$category_cfgs/niri.sh'"
  ["  󰏫 Edit Waybar"]="bash '$category_cfgs/waybar.sh'"
  ["  󰏫 Edit zsh"]="bash '$category_cfgs/zsh.sh'"
  ["  󰏫 Edit kitty"]="bash '$category_cfgs/kitty.sh'"
  ["  󰏫 Edit yazi"]="bash '$category_cfgs/yazi.sh'"
)
MENU_ORDER=(
  "󰣇 System"
  "  󰐥 Power Menu"
  "  󰚰 Update"
  "  $dunst_icon Do Not Disturb"
  "   Audio"
  "  󰖩 Network"
  " Configs"
  "   Open ~/.dotfiles"
  "  󰏫 Edit Niri"
  "  󰏫 Edit Waybar"
  "  󰏫 Edit zsh"
  "  󰏫 Edit kitty"
  "  󰏫 Edit yazi"
)

# Main
chosen=$(printf '%s\n' "${MENU_ORDER[@]}" | fuzzel -d -p "󰍜 ")

[ -z "$chosen" ] && exit 0
eval "${ACTIONS[$chosen]}"
