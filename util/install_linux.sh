#!/usr/bin/env bash

origin=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) || exit

# ensure that ~/.local/share/fonts exists
mkdir -p ~/.local/share/fonts

# remove all fonts from ~/.local/share/fonts that start with "Monaspace"
rm -rf ~/.local/share/fonts/Monaspace*

mkdir -p ~/.local/share/fonts/Monaspace/

# copy all fonts from ./otf to ~/.local/share/fonts
cp "${origin}/../fonts/otf/"* ~/.local/share/fonts/Monaspace/

# copy variable fonts from ./variable to ~/.local/share/fonts
cp "${origin}/../fonts/variable/"* ~/.local/share/fonts/Monaspace/

# Build font information caches
fc-cache -f
