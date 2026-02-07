#!/usr/bin/env bash

menu_items=" Back
  - Niri
  - Waybar
  - Dunst
  - fuzzel
  - fastfetch
  - zsh
  - yazi"

chosen=$(echo -e "$menu_items" | fuzzel -d -p " ")

[ -z "$chosen" ] && exit 0

clean_choice=$(echo "$chosen" | sed 's/^[^[:alnum:]]*//')

case "$clean_choice" in
	"Back")
		~/.local/scripts/fuzzel-menu.sh
		;;
	"Niri")
		$FILE_MANAGER ~/.dotfiles/niri/.config/niri/
		;;
	"Waybar")
		$FILE_MANAGER ~/.dotfiles/waybar/.config/waybar/
		;;
	"Dunst")
		$FILE_MANAGER ~/.dotfiles/dunst/.config/dunst/
		;;
	"fuzzel")
		$FILE_MANAGER ~/.dotfiles/fuzzel/.config/fuzzel/
		;;
	"fastfetch")
		$FILE_MANAGER ~/.dotfiles/fastfetch/.config/fastfetch/
		;;
	"zsh")
		$FILE_MANAGER ~/.dotfiles/zsh/.config/zsh/
		;;
	"yazi")
		$FILE_MANAGER ~/.dotfiles/yazi/.config/yazi/
		;;
	*)
		exit 0
		;;
esac
