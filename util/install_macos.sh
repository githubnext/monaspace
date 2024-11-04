#!/usr/bin/env bash

origin=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) || exit

# remove all fonts from ~/Library/Fonts that start with "Monaspace"
rm -rf ~/Library/Fonts/Monaspace*

# copy all fonts from ./otf to ~/Library/Fonts
cp "${origin}/../fonts/otf/"* ~/Library/Fonts

# copy variable fonts from ./variable to ~/Library/Fonts
cp "${origin}/../fonts/variable/"* ~/Library/Fonts