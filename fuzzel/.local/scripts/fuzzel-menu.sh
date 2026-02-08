#!/usr/bin/env bash

# 1. Checking DND
if [ "$(dunstctl is-paused)" == "true" ]; then
    dunst_icon="󰂛"
else
    dunst_icon="󰂚"
fi

# Main
menu_items="󰣇 System
  󰐥 Power Menu
  󰚰 Update
  $dunst_icon Do Not Disturb
 Configs
   Edit Configs
󱄄 Appearance
  󰑡 Waybar"

chosen=$(echo -e "$menu_items" | fuzzel -d -p "󰍜 ")

[ -z "$chosen" ] && exit 0

index=$(echo -e "$menu_items" | grep -nxF "$chosen" | cut -d: -f1)

case "$index" in
    2) # 󰐥 Power Menu
       ~/.local/scripts/fuzzel-system_power-menu.sh ;;
    3) # Update
       $TERMINAL sh -c "yay --diffmenu=false --cleanmenu=false --editmenu=false -Syu --noconfirm; echo 'Done! Press Enter...'; read" ;;
    4) # Do Not Disturb
       dunstctl set-paused toggle && exec "$0" ;;
    5) #  Configs 
        $FILE_MANAGER ~/.dotfiles
        ;;
    6) #  Edit Configs
        ~/.local/scripts/fuzzel-configs_edit-configs.sh
        ;;
    8) # 󰑡 Waybar
        $FILE_MANAGER ~/.config/waybar/
        ;;
    *)
        ~/.local/scripts/fuzzel-menu.sh
        ;;
esac
