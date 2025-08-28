#!/bin/bash  
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for setting SDDM wallpaper

iDIR="$HOME/.config/swaync/images"
wallpapers_dir="$HOME/Pictures/Wallpapers"
sddm_theme_dir="/usr/share/sddm/themes"
rofi_theme="$HOME/.config/rofi/config-wallpaper.rasi"

# Create wallpapers directory if it doesn't exist
if [ ! -d "$wallpapers_dir" ]; then
    mkdir -p "$wallpapers_dir"
    notify-send -i "$iDIR/wallpaper.png" "Info" "Created wallpapers directory: $wallpapers_dir"
fi

# Check if wallpapers directory has any images
wallpapers_array=($(find "$wallpapers_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort))

if [ ${#wallpapers_array[@]} -eq 0 ]; then
    notify-send -i "$iDIR/error.png" "Error" "No wallpapers found in $wallpapers_dir"
    exit 1
fi

# Use default rofi theme if custom one doesn't exist
if [ ! -f "$rofi_theme" ]; then
    rofi_command="rofi -i -dmenu -p 'Select SDDM Wallpaper'"
else
    rofi_command="rofi -i -dmenu -config $rofi_theme -p 'Select SDDM Wallpaper'"
fi

menu() {
    for wallpaper in "${wallpapers_array[@]}"; do
        echo "$wallpaper"
    done
}

set_sddm_wallpaper() {
    local wallpaper_path="$1"
    local success=false
    
    # For sugar-candy theme
    if [ -d "$sddm_theme_dir/sugar-candy" ]; then
        if sudo cp "$wallpaper_path" "$sddm_theme_dir/sugar-candy/Background.jpg" 2>/dev/null; then
            success=true
        fi
    fi
    
    # For other common SDDM themes
    for theme_dir in "$sddm_theme_dir"/*; do
        if [ -d "$theme_dir" ]; then
            theme_name=$(basename "$theme_dir")
            case "$theme_name" in
                "breeze"|"elarun"|"maldives"|"maya")
                    sudo cp "$wallpaper_path" "$theme_dir/background.jpg" 2>/dev/null && success=true
                    ;;
                "chili"|"clairvoyance")
                    sudo cp "$wallpaper_path" "$theme_dir/assets/background.jpg" 2>/dev/null && success=true
                    ;;
                *)
                    # Try common background file names
                    for bg_file in "background.jpg" "background.png" "wallpaper.jpg" "wallpaper.png"; do
                        if [ -f "$theme_dir/$bg_file" ]; then
                            sudo cp "$wallpaper_path" "$theme_dir/$bg_file" 2>/dev/null && success=true
                        fi
                    done
                    ;;
            esac
        fi
    done
    
    return $success
}

main() {
    choice=$(menu | ${rofi_command})
    
    if [ -z "$choice" ]; then
        exit 0
    fi
    
    wallpaper_path="$wallpapers_dir/$choice"
    
    if [ -f "$wallpaper_path" ]; then
        if set_sddm_wallpaper "$wallpaper_path"; then
            notify-send -i "$iDIR/wallpaper.png" "SDDM Wallpaper" "Successfully set: $choice"
        else
            notify-send -i "$iDIR/error.png" "SDDM Wallpaper" "Failed to set wallpaper. Check permissions or SDDM theme."
        fi
    else
        notify-send -i "$iDIR/error.png" "Error" "Wallpaper file not found: $choice"
    fi
}

# Check if rofi is already running
if pidof rofi > /dev/null; then
    pkill rofi
fi

main
