#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Kitty theme selection

iDIR="$HOME/.config/swaync/images"
rofi_theme="$HOME/.config/rofi/config-kitty-theme.rasi"

# Check if kitty is available
if ! command -v kitty >/dev/null 2>&1; then
    notify-send -i "$iDIR/error.png" "Error" "Kitty terminal not found"
    exit 1
fi

# Kitty configuration paths
themes_dir="$HOME/.config/kitty/themes"
config_file="$HOME/.config/kitty/kitty.conf"

# Create config directory if it doesn't exist
mkdir -p "$HOME/.config/kitty"

# Create themes directory if it doesn't exist
if [ ! -d "$themes_dir" ]; then
    mkdir -p "$themes_dir"
    # Clone kitty themes if directory is empty
    if [ -z "$(ls -A "$themes_dir" 2>/dev/null)" ]; then
        if command -v git >/dev/null 2>&1; then
            notify-send -i "$iDIR/kitty.png" "Kitty Themes" "Downloading themes..."
            git clone --depth 1 https://github.com/dexpota/kitty-themes.git /tmp/kitty-themes
            cp -r /tmp/kitty-themes/themes/* "$themes_dir/"
            rm -rf /tmp/kitty-themes
        else
            notify-send -i "$iDIR/error.png" "Error" "Git not found. Cannot download themes."
            exit 1
        fi
    fi
fi

# Get available themes
themes_array=($(find "$themes_dir" -name "*.conf" -exec basename {} .conf \; | sort))

if [ ${#themes_array[@]} -eq 0 ]; then
    notify-send -i "$iDIR/error.png" "Error" "No kitty themes found"
    exit 1
fi

# Add "Random" option
themes_array=("Random" "${themes_array[@]}")

# Use default rofi theme if custom one doesn't exist
if [ ! -f "$rofi_theme" ]; then
    rofi_command="rofi -i -dmenu"
else
    rofi_command="rofi -i -dmenu -config $rofi_theme"
fi

menu() {
    for theme in "${themes_array[@]}"; do
        echo "$theme"
    done
}

main() {
    choice=$(menu | ${rofi_command})
    
    if [ -z "$choice" ]; then
        exit 0
    fi
    
    if [[ "$choice" == "Random" ]]; then
        # Pick a random theme (excluding "Random")
        random_index=$((RANDOM % (${#themes_array[@]} - 1) + 1))
        theme_to_set="${themes_array[$random_index]}"
        notify-send -i "$iDIR/kitty.png" "Random Kitty theme:" "Selected: $theme_to_set"
    else
        theme_to_set="$choice"
        notify-send -i "$iDIR/kitty.png" "Kitty theme selected:" "$choice"
    fi
    
    # Apply theme
    theme_file="$themes_dir/$theme_to_set.conf"
    if [ -f "$theme_file" ]; then
        # Create kitty.conf if it doesn't exist
        if [ ! -f "$config_file" ]; then
            touch "$config_file"
        fi
        
        # Remove old theme includes and add new one
        sed -i '/^include.*themes.*\.conf$/d' "$config_file"
        echo "include themes/$theme_to_set.conf" >> "$config_file"
        
        # Reload kitty instances if any are running
        if command -v pgrep >/dev/null 2>&1 && pgrep -x kitty >/dev/null; then
            for socket in $(find /tmp -name "kitty-*" -type s 2>/dev/null); do
                kitty @ --to unix:"$socket" load-config 2>/dev/null || true
            done
        fi
        
        notify-send -i "$iDIR/kitty.png" "Kitty theme" "Applied: $theme_to_set"
    else
        notify-send -i "$iDIR/error.png" "Error" "Theme file not found: $theme_file"
    fi
}

# Check if rofi is already running
if pidof rofi > /dev/null; then
    pkill rofi
fi

main
