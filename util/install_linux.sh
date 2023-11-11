#!/bin/bash

# create fonts dir if not present
mkdir -p ~/.local/share/fonts

# remove all fonts from ~/.local/share/fonts that start with "Monaspace"
rm -rf ~/.local/share/fonts/Monaspace*

# get dir of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# copy all fonts from monaspace root/fonts/otf to ~/.local/share/fonts
cp $SCRIPT_DIR/../fonts/otf/* ~/.local/share/fonts

# copy variable fonts from monaspace root/fonts/variable to ~/.local/share/fonts
cp $SCRIPT_DIR/../fonts/variable/* ~/.local/share/fonts

# Build font information caches
fc-cache -f
