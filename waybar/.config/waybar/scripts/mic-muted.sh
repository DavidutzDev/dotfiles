#!/usr/bin/env bash

SOURCE=$(pactl get-default-source)
MUTED=$(pactl get-source-mute "$SOURCE" | awk '{print $2}')

if [ "$MUTED" = "yes" ]; then
    # Visible
    echo '{"text":"󰍭","tooltip":"Mic muted"}'
else
    # Hidden
    echo '{"text":""}'
fi
