#!/bin/bash
set -euo pipefail
niri msg --json windows | \
  jq -r --arg t waybar-custom-menu \
  '.[] | select(.title==$t) | .id' | \
  xargs -r -n1 niri msg action close-window --id
