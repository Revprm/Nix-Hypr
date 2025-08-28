#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Game Mode - disable animations and effects for better performance

iDIR="$HOME/.config/swaync/images"
STATE_FILE="$HOME/.cache/gamemode_state"

if [ -f "$STATE_FILE" ]; then
    # Game mode is ON, turn it OFF
    hyprctl keyword animations:enabled true
    hyprctl keyword decoration:blur:enabled true
    hyprctl keyword decoration:drop_shadow true
    hyprctl keyword misc:vfr true
    rm "$STATE_FILE"
    notify-send -i "$iDIR/game.png" "Game Mode" "Disabled - Visual effects restored"
else
    # Game mode is OFF, turn it ON
    hyprctl keyword animations:enabled false
    hyprctl keyword decoration:blur:enabled false
    hyprctl keyword decoration:drop_shadow false
    hyprctl keyword misc:vfr false
    touch "$STATE_FILE"
    notify-send -i "$iDIR/game.png" "Game Mode" "Enabled - Performance optimized"
fi
