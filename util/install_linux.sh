#!/bin/bash

# Set the current user
USER=$(logname)
echo "Current user is $USER"

# Set the target font directory
TARGET_DIR="/home/$USER/.local/share/fonts/Monaspace"

# Create the ~/.local/share/fonts/ directory if it doesn't exist
mkdir -p "/home/$USER/.local/share/fonts"

# Remove the Monaspace directory if it exists
if [ -d "$TARGET_DIR" ]; then
  rm -rf "$TARGET_DIR"
fi

# Create the Monaspace directory
mkdir -p "$TARGET_DIR"

# Copy fonts from the local repository to the target directory
cp -r ./fonts/otf/* "$TARGET_DIR/"
cp -r ./fonts/variable/* "$TARGET_DIR/"

# Update the font cache
fc-cache -fv

echo "Fonts copied to $TARGET_DIR and font cache updated."
