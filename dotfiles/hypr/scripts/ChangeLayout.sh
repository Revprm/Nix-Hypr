#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for switching between dwindle and master layout

iDIR="$HOME/.config/swaync/images"

# Get current layout
current_layout=$(hyprctl getoption general:layout -j | jq -r '.str')

if [ "$current_layout" = "dwindle" ]; then
    # Switch to master
    hyprctl keyword general:layout master
    notify-send -i "$iDIR/layout.png" "Layout" "Master"
else
    # Switch to dwindle
    hyprctl keyword general:layout dwindle
    notify-send -i "$iDIR/layout.png" "Layout" "Dwindle"
fi
