#!/usr/bin/env bash

menu_items=" Back
  󰐥 Shutdown
   Reboot
   BIOS Setup"

chosen=$(echo -e "$menu_items" | fuzzel -d -p "󰐥 ")

[ -z "$chosen" ] && exit 0

index=$(echo -e "$menu_items" | grep -nxF "$chosen" | cut -d: -f1)

case "$index" in
    2)
        systemctl poweroff
        ;;
    3)
	systemctl reboot
        ;;
    4)
	systemctl reboot --firmware-setup
        ;;
    *)
        ~/.local/scripts/fuzzel-menu.sh
        ;;
esac
