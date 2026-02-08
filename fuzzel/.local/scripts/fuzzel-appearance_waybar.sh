#!/usr/bin/env bash

menu_items=" Back
  󱗼 Modules"

chosen=$(echo -e "$menu_items" | fuzzel -d -p "󱄄 ")

[ -z "$chosen" ] && exit 0

index=$(echo -e "$menu_items" | grep -nxF "$chosen" | cut -d: -f1)

case "$index" in
    2)
        $TERMINAL sh -c "~/.local/scripts/waybar-customizer-script-wrapper.sh; echo 'Done! Press Enter...'; read" ;;
    *)
        ~/.local/scripts/fuzzel-menu.sh
        ;;
esac
