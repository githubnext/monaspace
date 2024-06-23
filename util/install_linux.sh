#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error and exit immediately
set -o pipefail  # Return the exit status of the last command in the pipeline that failed

echo "Starting font installation script..."

# Ensure that ~/.local/share/fonts exists
echo "Creating directory: ~/.local/share/fonts"
mkdir -p ~/.local/share/fonts

# Remove all fonts from ~/.local/share/fonts that start with "Monaspace"
echo "Removing existing Monaspace fonts from ~/.local/share/fonts"
rm -rf ~/.local/share/fonts/Monaspace*

# Recreate the Monaspace directory
echo "Creating directory: ~/.local/share/fonts/Monaspace/"
mkdir -p ~/.local/share/fonts/Monaspace/

# Copy all fonts from ./otf to ~/.local/share/fonts/Monaspace/
if [ -d "./fonts/otf" ]; then
    echo "Copying fonts from ./fonts/otf/ to ~/.local/share/fonts/Monaspace/"
    cp -v ./fonts/otf/* ~/.local/share/fonts/Monaspace/ || echo "No files to copy from ./fonts/otf"
else
    echo "Directory ./fonts/otf does not exist"
fi

# Copy variable fonts from ./variable to ~/.local/share/fonts/Monaspace/
if [ -d "./fonts/variable" ]; then
    echo "Copying fonts from ./fonts/variable/ to ~/.local/share/fonts/Monaspace/"
    cp -v ./fonts/variable/* ~/.local/share/fonts/Monaspace/ || echo "No files to copy from ./fonts/variable"
else
    echo "Directory ./fonts/variable does not exist"
fi

# Build font information caches
echo "Rebuilding font information caches with fc-cache -f"
fc-cache -f

echo "Font installation completed successfully."