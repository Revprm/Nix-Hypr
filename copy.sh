#!/bin/bash

# --- Start of Configuration Files Copy ---

# Define the source directory containing all your config folders.
# This assumes your script is run from the root of your project where 'assets' is.
HYPR_CONFIG="config"

# Define the standard destination for user configurations.
CONFIG_DEST_DIR="$HOME/.config"

# Check if the assets directory exists.
if [ ! -d "$HYPR_CONFIG" ]; then
    echo "!!! ERROR: Assets directory '$HYPR_CONFIG' not found. Cannot copy configs."
    exit 1
fi

echo ">>> Starting to copy all configuration files from '$HYPR_CONFIG'..."

# Create the main ~/.config directory if it doesn't exist.
mkdir -p "$CONFIG_DEST_DIR"

# Loop through each item in the assets directory.
for CONFIG_FOLDER in "$HYPR_CONFIG"/*; do
    # Check if the item is a directory
    if [ -d "$CONFIG_FOLDER" ]; then
        # Extract the base name of the config folder (e.g., 'hypr', 'kitty')
        FOLDER_NAME=$(basename "$CONFIG_FOLDER")
        DEST_PATH="$CONFIG_DEST_DIR/$FOLDER_NAME"
        
        echo "--> Processing '$FOLDER_NAME' configuration..."
        
        # If a config with the same name already exists, create a backup.
        if [ -d "$DEST_PATH" ]; then
            echo "    ... Found existing config at $DEST_PATH. Creating backup."
            # Create a timestamp for the backup
            BACKUP_TIMESTAMP=$(date +%Y%m%d-%H%M%S)
            mv -v "$DEST_PATH" "${DEST_PATH}.backup-$BACKUP_TIMESTAMP"
        fi
        
        # Copy the new configuration folder recursively and verbosely.
        echo "    ... Copying new config to $CONFIG_DEST_DIR"
        cp -rv "$CONFIG_FOLDER" "$CONFIG_DEST_DIR/"
        echo "    ... Done."
    fi
done

echo ">>> All configurations successfully copied to $CONFIG_DEST_DIR"

# --- End of Configuration Files Copy ---