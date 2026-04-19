#!/bin/bash
set -euo pipefail
title=waybar-custom-menu
ids=$(niri msg --json windows | jq -r --arg t $title '.[]|select(.title==$t)|.id')

if [ -n "$ids" ]; then
	printf '%s\n' "$ids" | xargs -r -n1 niri msg action close-window --id
else
	footclient --title $title -e "$@"
fi
