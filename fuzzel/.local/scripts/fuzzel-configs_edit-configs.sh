#!/usr/bin/env bash

menu_items=" Back
  󱓡 Niri
  󱗼 Waybar
  󰂚 Dunst
  󰍜 Fuzzel
  󰣇 Fastfetch
   Zsh
  󰇥 Yazi"

chosen=$(echo -e "$menu_items" | fuzzel -d -p " ")

[ -z "$chosen" ] && exit 0

index=$(echo -e "$menu_items" | grep -nxF "$chosen" | cut -d: -f1)

case "$index" in
    2)
        $FILE_MANAGER ~/.dotfiles/niri/.config/niri/
        ;;
    3)
        $FILE_MANAGER ~/.dotfiles/waybar/.config/waybar/
        ;;
    4)
        $FILE_MANAGER ~/.dotfiles/dunst/.config/dunst/
        ;;
    5)
        $FILE_MANAGER ~/.dotfiles/fuzzel/.config/fuzzel/
        ;;
    6)
        $FILE_MANAGER ~/.dotfiles/fastfetch/.config/fastfetch/
        ;;
    7)
        $FILE_MANAGER ~/.dotfiles/zsh/.config/zsh/
        ;;
    8)
        $FILE_MANAGER ~/.dotfiles/yazi/.config/yazi/
        ;;
    *)
        ~/.local/scripts/fuzzel-menu.sh
        ;;
esac
