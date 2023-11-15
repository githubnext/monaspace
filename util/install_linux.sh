#!/bin/bash

# Create the users local fonts folder if it doesn't exist
mkdir -p ~/.local/share/fonts

# remove all fonts from ~/.local/share/fonts that start with "Monaspace"
rm -rf ~/.local/share/fonts/Monaspace*

# copy all fonts from ./otf to ~/.local/share/fonts
cp ../fonts/otf/* ~/.local/share/fonts

# copy variable fonts from ./variable to ~/.local/share/fonts
cp ../fonts/variable/* ~/.local/share/fonts

# Build font information caches
fc-cache -f
