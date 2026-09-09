#!/usr/bin/env sh

# Checks if an external monitor is connected
if hyprctl monitors -j | jq '.[].name' | grep -v 'eDP-1'; then
  if [[ "$1" == "close" ]]; then
    # Disable laptop screen when lid is closed; Hyprland automatically
    # moves its workspaces/windows onto the remaining monitors.
    hyprctl eval 'hl.monitor({output="eDP-1", disabled=true})'
  elif [[ "$1" == "open" ]]; then
    # Re-enable laptop screen when lid is open, at its normal position
    # (centered below the two docked externals -- see hyprland.lua)
    hyprctl eval 'hl.monitor({output="eDP-1", mode="2880x1800@60", position="1600x1440", scale=1.5, disabled=false})'
  fi
fi
