#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for per-window opacity/transparency control

iDIR="$HOME/.config/swaync/images"
rofi_theme="$HOME/.config/rofi/config-window-opacity.rasi"

# Get active window address
get_active_window() {
    hyprctl activewindow -j | jq -r '.address'
}

# Get window opacity
get_window_opacity() {
    local window_addr="$1"
    hyprctl clients -j | jq -r ".[] | select(.address == \"$window_addr\") | .opacity"
}

# Opacity options
opacity_options=(
    "1.0 (Opaque)"
    "0.9 (90%)"
    "0.8 (80%)"
    "0.7 (70%)"
    "0.6 (60%)"
    "0.5 (50%)"
    "0.4 (40%)"
    "0.3 (30%)"
    "Reset to default"
)

# Use default rofi theme if custom one doesn't exist
if [ ! -f "$rofi_theme" ]; then
    rofi_command="rofi -i -dmenu -p 'Window Opacity'"
else
    rofi_command="rofi -i -dmenu -config $rofi_theme -p 'Window Opacity'"
fi

menu() {
    for option in "${opacity_options[@]}"; do
        echo "$option"
    done
}

main() {
    # Get active window
    active_window=$(get_active_window)
    
    if [ "$active_window" = "null" ] || [ -z "$active_window" ]; then
        notify-send -i "$iDIR/error.png" "Error" "No active window found"
        exit 1
    fi
    
    # Get current opacity
    current_opacity=$(get_window_opacity "$active_window")
    
    # Show current opacity in notification
    notify-send -i "$iDIR/window.png" "Current Window" "Opacity: ${current_opacity}"
    
    choice=$(menu | ${rofi_command})
    
    if [ -z "$choice" ]; then
        exit 0
    fi
    
    case "$choice" in
        "1.0 (Opaque)")
            hyprctl setprop address:"$active_window" alpha 1.0
            notify-send -i "$iDIR/window.png" "Window Opacity" "Set to 100% (Opaque)"
            ;;
        "0.9 (90%)")
            hyprctl setprop address:"$active_window" alpha 0.9
            notify-send -i "$iDIR/window.png" "Window Opacity" "Set to 90%"
            ;;
        "0.8 (80%)")
            hyprctl setprop address:"$active_window" alpha 0.8
            notify-send -i "$iDIR/window.png" "Window Opacity" "Set to 80%"
            ;;
        "0.7 (70%)")
            hyprctl setprop address:"$active_window" alpha 0.7
            notify-send -i "$iDIR/window.png" "Window Opacity" "Set to 70%"
            ;;
        "0.6 (60%)")
            hyprctl setprop address:"$active_window" alpha 0.6
            notify-send -i "$iDIR/window.png" "Window Opacity" "Set to 60%"
            ;;
        "0.5 (50%)")
            hyprctl setprop address:"$active_window" alpha 0.5
            notify-send -i "$iDIR/window.png" "Window Opacity" "Set to 50%"
            ;;
        "0.4 (40%)")
            hyprctl setprop address:"$active_window" alpha 0.4
            notify-send -i "$iDIR/window.png" "Window Opacity" "Set to 40%"
            ;;
        "0.3 (30%)")
            hyprctl setprop address:"$active_window" alpha 0.3
            notify-send -i "$iDIR/window.png" "Window Opacity" "Set to 30%"
            ;;
        "Reset to default")
            hyprctl setprop address:"$active_window" alpha 1.0
            notify-send -i "$iDIR/window.png" "Window Opacity" "Reset to default"
            ;;
    esac
}

# Check if rofi is already running
if pidof rofi > /dev/null; then
    pkill rofi
fi

main
