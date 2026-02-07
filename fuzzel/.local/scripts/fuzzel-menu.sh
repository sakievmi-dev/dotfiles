#!/usr/bin/env bash

menu_items=" Configs
   Edit Configs"

chosen=$(echo -e "$menu_items" | fuzzel -d -p "󰍜 ")

[ -z "$chosen" ] && exit 0

clean_choice=$(echo "$chosen" | sed 's/^[^[:alnum:]]*//')

echo $clean_choice

case "$clean_choice" in
	#  Configs
	"Configs")
	        $FILE_MANAGER ~/.dotfiles
		;;
	"Edit Configs")
		
		;;
	*)
		exit 0
		;;
esac
