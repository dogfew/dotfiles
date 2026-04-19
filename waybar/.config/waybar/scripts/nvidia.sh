#!/usr/bin/env bash
set -euo pipefail
u=$(
  nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits \
  | head -n1 | tr -d '[:space:]'
)
line=$(
  nvidia-smi --query-gpu=clocks.gr,clocks.mem,temperature.gpu,fan.speed,power.draw,power.limit \
    --format=csv,noheader,nounits \
  | head -n1
)

IFS=',' read -r gr mem temp fan pdraw plim <<<"$line"

gr="${gr//[[:space:]]/}"
mem="${mem//[[:space:]]/}"
temp="${temp//[[:space:]]/}"
fan="${fan//[[:space:]]/}"
pdraw="${pdraw//[[:space:]]/}"
plim="${plim//[[:space:]]/}"

text="$(printf "%2d%%" "$u")"
tooltip="$(printf "GPU: %sMHz\nMem: %sMHz\nTemp: %s°C\nFan: %4s%%\nPow: %s/%s W" \
  "$gr" "$mem" "$temp" "$fan" "$pdraw" "$plim")"

jq -cn --arg text "$text" --arg tooltip "$tooltip" '{text:$text, tooltip:$tooltip}'

