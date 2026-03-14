#!/usr/bin/env bash

# Gruvbox colors
GREEN=0xffb8bb26
YELLOW=0xfffabd2f
RED=0xfffb4934
ORANGE=0xfffe8019

# Much faster than `top -l 1`
CPU=$(ps -A -o %cpu | awk '{s+=$1} END {printf "%.0f", s/'"$(sysctl -n hw.logicalcpu)"'}')

if   [ "$CPU" -ge 80 ]; then COLOR=$RED
elif [ "$CPU" -ge 50 ]; then COLOR=$ORANGE
elif [ "$CPU" -ge 25 ]; then COLOR=$YELLOW
else                          COLOR=$GREEN
fi

sketchybar --set "$NAME" label="${CPU}%" icon.color=$COLOR
