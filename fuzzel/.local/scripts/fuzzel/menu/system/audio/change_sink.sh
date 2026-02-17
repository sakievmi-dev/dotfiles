#!/usr/bin/env bash

SINK_LIST=$(pactl list sinks | perl -00 -ne 'if (/Name: (.+?)\s+Description: (.+?)$/m) { print "󱡬 $2                                 | $1\n" }')
MENU_ITEMS=" Back"$'\n'"$SINK_LIST"
SELECTED_LINE=$(echo "$MENU_ITEMS" | fuzzel -d -p "󱡬 ")

if [[ "$SELECTED_LINE" == " Back" || -z "$SELECTED_LINE" ]]; then
    [[ "$SELECTED_LINE" == " Back" ]] && bash ~/.local/scripts/fuzzel/menu/system/audio.sh
    exit 0
fi

SINK_NAME=$(echo "$SELECTED_LINE" | awk -F ' | ' '{print $NF}' | xargs)

if [ -n "$SINK_NAME" ]; then
    pactl set-default-sink "$SINK_NAME"

    pactl list sink-inputs short | cut -f1 | while read -r stream; do
        pactl move-sink-input "$stream" "$SINK_NAME"
    done

    pactl set-sink-mute "$SINK_NAME" 0
fi
