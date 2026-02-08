#!/bin/bash

customizer_script=~/.local/scripts/waybar-change-modules-right.py

CHOICE=$(gum choose --item.foreground 250 "Change modules on the right side" "Change modules on the left side (WIP)" "Exit")

case $CHOICE in
	"Change modules on the right side")
	$customizer_script -m
	modules=$(gum input --placeholder "Enter modules separated by ';'. Example: 'niri/language;tray'")

	echo $modules

	$customizer_script --modules_right $modules

	echo 'Done! Press Enter...'; read
	;;
esac
