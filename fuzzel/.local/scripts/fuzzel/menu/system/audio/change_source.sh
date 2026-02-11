#!/usr/bin/env bash

SOURCE_LIST=$(pactl list sources | perl -00 -ne 'if (/\WName:\W+(.+)\W+Description:\W+(.+)/g) { print " $2\n" }' | perl -nle '/^\s+(.+)$/ && print "  󱡬 $1"') 

MENU_ITEMS=" Back"$'\n'"$SOURCE_LIST"

SELECTED_DESC=$(echo "$MENU_ITEMS" | fuzzel -d -p "󱡬 " | sed 's/^\s*//')

if [[ "$SELECTED_DESC" == " Back" ]]; then
	bash ~/.local/scripts/fuzzel/menu/system/audio.sh
	exit 0
fi

if [ -n "$SELECTED_DESC" ]; then
	CLEARED_DESC=$(echo "$SELECTED_DESC" | sed 's/^.*󱡬 //')
	echo $CLEARED_DESC
	SINK_ID=$(pactl list sources | perl -00 -ne "if (/Description: \Q$CLEARED_DESC\E/ && /object\.serial = \"(\d+)\"/s) { print \$1 }")
	echo $SINK_ID
	pactl set-default-source "$SINK_ID"
fi
