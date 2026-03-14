#!/usr/bin/env bash

GREEN=0xffb8bb26
YELLOW=0xfffabd2f
RED=0xfffb4934
AQUA=0xff8ec07c

ICON_FULL=$(printf '\uf240')
ICON_3=$(printf '\uf241')
ICON_2=$(printf '\uf242')
ICON_1=$(printf '\uf243')
ICON_EMPTY=$(printf '\uf244')
ICON_CHG=$(printf '\uf0e7')

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

[ -z "$PERCENTAGE" ] && exit 0

if   [ "$PERCENTAGE" -ge 90 ]; then ICON=$ICON_FULL  ; COLOR=$GREEN
elif [ "$PERCENTAGE" -ge 70 ]; then ICON=$ICON_3     ; COLOR=$GREEN
elif [ "$PERCENTAGE" -ge 50 ]; then ICON=$ICON_2     ; COLOR=$AQUA
elif [ "$PERCENTAGE" -ge 30 ]; then ICON=$ICON_1     ; COLOR=$YELLOW
else                                 ICON=$ICON_EMPTY ; COLOR=$RED
fi

[ -n "$CHARGING" ] && ICON=$ICON_CHG && COLOR=$AQUA

sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="${PERCENTAGE}%"
