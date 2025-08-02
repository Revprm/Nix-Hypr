#!/usr/bin/env bash

clear

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
RESET="$(tput sgr0)"

# --- Determine the hostname ---
# Prompt the user for the hostname, with the current hostname as the default.
CURRENT_HOST=$(hostname 2>/dev/null || echo "default")
read -rp "${CAT} Please enter the hostname to update [$CURRENT_HOST]: ${RESET}" TARGET_HOSTNAME
if [ -z "$TARGET_HOSTNAME" ]; then
    TARGET_HOSTNAME="$CURRENT_HOST"
fi

# --- Check if the specified host configuration exists ---
if [ ! -d "hosts/$TARGET_HOSTNAME" ]; then
    printf "${ERROR} Host configuration '$TARGET_HOSTNAME' not found in hosts/ directory.\n"
    exit 1
fi

# --- Main Update Process ---
printf "\n${INFO} Starting NixOS system update for host: %s\n" "$TARGET_HOSTNAME"
printf "${NOTE} This will update your system based on the current flake configuration.\n"
printf "${NOTE} Your personal dotfiles in ~/.config will not be changed.\n\n"
printf "This may take a while, please be patient.\n"

# Execute the NixOS rebuild command.
# The '--upgrade' flag fetches the latest versions of your flake inputs.
sudo nixos-rebuild switch --flake .#"$TARGET_HOSTNAME" --upgrade

# Check the exit code of the last command to determine if it was successful.
if [ $? -eq 0 ]; then
    printf "\n${OK} NixOS system updated successfully!\n"
else
    printf "\n${ERROR} An error occurred during the NixOS update process. Please check the output above for details.\n"
fi
