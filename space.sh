#!/usr/bin/env bash

# Colors (Gruvbox)
ACTIVE_ICON_COLOR=0xfffabd2f    # Yellow bright
INACTIVE_ICON_COLOR=0xffa89984  # FG3 muted
ACTIVE_BG=0xff3c3836            # BG1
INACTIVE_BG=0x00000000          # Transparent

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" \
    icon.color=$ACTIVE_ICON_COLOR \
    background.color=$ACTIVE_BG \
    background.drawing=on
else
  sketchybar --set "$NAME" \
    icon.color=$INACTIVE_ICON_COLOR \
    background.color=$INACTIVE_BG \
    background.drawing=off
fi
