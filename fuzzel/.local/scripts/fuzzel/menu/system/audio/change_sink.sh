#!/usr/bin/env bash

SINK_LIST=$(pactl list sinks | perl -00 -ne 'if (/Description:\s*(.+)/) { print "  󱡬 $1\n" }')
MENU_ITEMS=" Back"$'\n'"$SINK_LIST"
SELECTED_DESC=$(echo "$MENU_ITEMS" | fuzzel -d -p "󱡬 " | sed 's/^\s*//')

if [[ "$SELECTED_DESC" == " Back" || -z "$SELECTED_DESC" ]]; then
    [[ "$SELECTED_DESC" == " Back" ]] && bash ~/.local/scripts/fuzzel/menu/system/audio.sh
    exit 0
fi

CLEARED_DESC=$(echo "$SELECTED_DESC" | sed 's/^󱡬 //')
SINK_NAME=$(pactl list sinks | perl -00 -ne "if (/Description: \Q$CLEARED_DESC\E/m && /Name: (.+)/m) { print \$1 }")

if [ -n "$SINK_NAME" ]; then
    pactl set-default-sink "$SINK_NAME"

    # Moving all streams to active sink
    pactl list sink-inputs short | cut -f1 | while read -r stream; do
        pactl move-sink-input "$stream" "$SINK_NAME"
    done
fi
