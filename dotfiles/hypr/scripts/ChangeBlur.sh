#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for toggling blur effects

iDIR="$HOME/.config/swaync/images"

# Get current blur status
current_blur=$(hyprctl getoption decoration:blur:enabled -j | jq -r '.int')

if [ "$current_blur" -eq 1 ]; then
    # Disable blur
    hyprctl keyword decoration:blur:enabled false
    notify-send -i "$iDIR/blur.png" "Blur Effects" "Disabled"
else
    # Enable blur
    hyprctl keyword decoration:blur:enabled true
    notify-send -i "$iDIR/blur.png" "Blur Effects" "Enabled"
fi
