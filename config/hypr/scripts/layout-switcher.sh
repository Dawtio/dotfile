#!/bin/bash

# Switch layout windows type.
layouts=(scrolling dwindle master)

# Show menu
selected=$(printf '%s\n' "${layouts[@]}" | rofi -dmenu -p "Select Layout" -theme ~/.config/colorschemes/rofi-theme.rasi)

# Apply selected layout if not empty
if [[ -n "$selected" ]]; then
  sed -i "s/binds\.bind_[a-z]*/binds.bind_${selected}/g" ~/.config/hypr/hyprland_bind.lua
  hyprctl eval "hl.config({general={layout=\"${selected}\"}})"
fi
