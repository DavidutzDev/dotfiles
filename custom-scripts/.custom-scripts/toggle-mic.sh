#!/usr/bin/env bash

OSD="swayosd-client --monitor \"$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')\""

SOURCE=$(pactl get-default-source)
MUTED=$(pactl get-source-mute "$SOURCE" | awk '{print $2}')

if [ "$MUTED" == "yes" ]; then
    pactl set-source-mute "$SOURCE" 0
    $OSD --custom-message "Mic unmuted" --custom-icon audio-input-microphone
else
    pactl set-source-mute "$SOURCE" 1
    $OSD --custom-message "Mic muted" --custom-icon audio-input-microphone
fi

# Update waybar
pkill -SIGRTMIN+9 waybar
