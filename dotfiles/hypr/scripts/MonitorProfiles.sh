#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for switching between monitor configurations

iDIR="$HOME/.config/swaync/images"
rofi_theme="$HOME/.config/rofi/config-monitor-profiles.rasi"
profiles_dir="$HOME/.config/hypr/monitor-profiles"

# Create profiles directory if it doesn't exist
if [ ! -d "$profiles_dir" ]; then
    mkdir -p "$profiles_dir"
    
    # Create some example profiles
    cat > "$profiles_dir/laptop-only.conf" << 'EOF'
# Laptop screen only
monitor = eDP-1, 2880x1800@90, 0x0, 1
monitor = , disable
EOF

    cat > "$profiles_dir/external-only.conf" << 'EOF'
# External monitor only  
monitor = DP-1, 1920x1080@165, 0x0, 1
monitor = eDP-1, disable
EOF

    cat > "$profiles_dir/dual-monitor.conf" << 'EOF'
# Dual monitor setup
monitor = eDP-1, 2880x1800@90, 1920x0, 1.67
monitor = DP-1, 1920x1080@165, 0x0, 1
EOF

    cat > "$profiles_dir/mirror.conf" << 'EOF'
# Mirror displays
monitor = eDP-1, 2880x1800@90, 0x0, 1
monitor = DP-1, 2880x1800@90, 0x0, 1
EOF
    
    notify-send -i "$iDIR/monitor.png" "Monitor Profiles" "Created example profiles"
fi

# Get available profiles
profiles_array=($(find "$profiles_dir" -name "*.conf" -exec basename {} .conf \; | sort))

if [ ${#profiles_array[@]} -eq 0 ]; then
    notify-send -i "$iDIR/error.png" "Error" "No monitor profiles found"
    exit 1
fi

# Use default rofi theme if custom one doesn't exist
if [ ! -f "$rofi_theme" ]; then
    rofi_command="rofi -i -dmenu"
else
    rofi_command="rofi -i -dmenu -config $rofi_theme"
fi

menu() {
    for profile in "${profiles_array[@]}"; do
        echo "$profile"
    done
}

main() {
    choice=$(menu | ${rofi_command})
    
    if [ -z "$choice" ]; then
        exit 0
    fi
    
    profile_file="$profiles_dir/$choice.conf"
    if [ -f "$profile_file" ]; then
        # Apply monitor configuration
        while IFS= read -r line; do
            # Skip comments and empty lines
            if [[ $line =~ ^[[:space:]]*# ]] || [[ -z "${line// }" ]]; then
                continue
            fi
            # Apply monitor configuration
            if [[ $line =~ ^monitor ]]; then
                hyprctl keyword "$line"
            fi
        done < "$profile_file"
        
        notify-send -i "$iDIR/monitor.png" "Monitor Profile" "Applied: $choice"
    else
        notify-send -i "$iDIR/error.png" "Error" "Profile not found: $choice"
    fi
}

# Check if rofi is already running
if pidof rofi > /dev/null; then
    pkill rofi
fi

main
