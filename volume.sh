#!/usr/bin/env bash

ICON_HIGH=$(printf '\uf028')
ICON_MED=$(printf '\uf027')
ICON_LOW=$(printf '\uf026')
ICON_MUTE=$(printf '\ueee8')

if [ "$SENDER" = "volume_change" ]; then
  VOLUME=$INFO
else
  VOLUME=$(osascript -e 'output volume of (get volume settings)')
fi

if   [ "$VOLUME" -ge 60 ]; then ICON=$ICON_HIGH
elif [ "$VOLUME" -ge 30 ]; then ICON=$ICON_MED
elif [ "$VOLUME" -gt 0  ]; then ICON=$ICON_LOW
else                             ICON=$ICON_MUTE
fi

sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
