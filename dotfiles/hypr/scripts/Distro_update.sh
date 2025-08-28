#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for system updates - NixOS compatible

iDIR="$HOME/.config/swaync/images"

# Function to run update in terminal
run_update() {
    local cmd="$1"
    local title="$2"
    
    # Check for available terminals
    if command -v kitty >/dev/null 2>&1; then
        kitty --title "$title" sh -c "$cmd; read -p 'Press Enter to continue...'"
    elif command -v alacritty >/dev/null 2>&1; then
        alacritty --title "$title" -e sh -c "$cmd; read -p 'Press Enter to continue...'"
    elif command -v gnome-terminal >/dev/null 2>&1; then
        gnome-terminal --title="$title" -- sh -c "$cmd; read -p 'Press Enter to continue...'"
    else
        # Fallback - run without terminal
        eval "$cmd"
    fi
}

# Check if running NixOS
if [ -n "$(grep -i nixos < /etc/os-release)" ]; then
    notify-send -i "$iDIR/update.png" "System Update" "Starting NixOS update..."
    
    if command -v nixos-rebuild >/dev/null 2>&1; then
        run_update "sudo nixos-rebuild switch --upgrade" "NixOS System Update"
        notify-send -i "$iDIR/update.png" "System Update" "NixOS update completed"
    else
        # Home Manager update
        if command -v home-manager >/dev/null 2>&1; then
            run_update "home-manager switch" "Home Manager Update"
            notify-send -i "$iDIR/update.png" "System Update" "Home Manager updated"
        else
            notify-send -i "$iDIR/error.png" "Update Error" "No update method available"
        fi
    fi
else
    # Non-NixOS systems
    if command -v pacman >/dev/null 2>&1; then
        # Arch Linux
        run_update "sudo pacman -Syu" "Arch Linux Update"
    elif command -v apt >/dev/null 2>&1; then
        # Debian/Ubuntu
        run_update "sudo apt update && sudo apt upgrade" "APT Update"
    elif command -v dnf >/dev/null 2>&1; then
        # Fedora
        run_update "sudo dnf update" "DNF Update"
    elif command -v zypper >/dev/null 2>&1; then
        # openSUSE
        run_update "sudo zypper up" "Zypper Update"
    else
        notify-send -i "$iDIR/error.png" "Update Error" "Unknown package manager"
    fi
fi
