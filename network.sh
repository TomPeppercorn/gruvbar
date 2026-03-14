#!/usr/bin/env bash

# Check for active WiFi via route table - no SSID parsing needed
WIFI_IF=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')
LINK=$(ipconfig getifaddr "$WIFI_IF" 2>/dev/null)

if [ -n "$LINK" ]; then
  ICON="󰖩"
  LABEL="WiFi"
else
  for iface in en1 en2 en3; do
    IP=$(ipconfig getifaddr "$iface" 2>/dev/null)
    if [ -n "$IP" ]; then
      ICON="󰈀"
      LABEL="Ethernet"
      break
    fi
  done
  if [ -z "$LABEL" ]; then
    ICON="󰖪"
    LABEL="No Network"
  fi
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
