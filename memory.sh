#!/usr/bin/env bash

ICON=$(printf '\uf2db')   # nf-fa-microchip, well supported in NF v2/v3

vm_stat_output=$(vm_stat)
pages_active=$(echo "$vm_stat_output" | awk '/Pages active/ {gsub(/\./, "", $3); print $3}')
pages_wired=$(echo "$vm_stat_output"  | awk '/Pages wired/ {gsub(/\./, "", $4); print $4}')
pages_compressed=$(echo "$vm_stat_output" | awk '/Pages occupied by compressor/ {gsub(/\./, "", $5); print $5}')

page_size=4096
used_bytes=$(( (pages_active + pages_wired + pages_compressed) * page_size ))
used_gb=$(echo "scale=1; $used_bytes / 1073741824" | bc)

sketchybar --set "$NAME" icon="$ICON" label="${used_gb}G"
