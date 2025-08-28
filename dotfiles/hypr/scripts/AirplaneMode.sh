#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Airplane Mode toggle

iDIR="$HOME/.config/swaync/images"

# Check current airplane mode status
airplane_status=$(nmcli radio wifi)

if [ "$airplane_status" = "enabled" ]; then
    # Turn off WiFi and Bluetooth
    nmcli radio wifi off
    if command -v bluetoothctl >/dev/null 2>&1; then
        bluetoothctl power off
    fi
    notify-send -i "$iDIR/airplane.png" "Airplane Mode" "Enabled"
else
    # Turn on WiFi and Bluetooth  
    nmcli radio wifi on
    if command -v bluetoothctl >/dev/null 2>&1; then
        bluetoothctl power on
    fi
    notify-send -i "$iDIR/airplane.png" "Airplane Mode" "Disabled"
fi
