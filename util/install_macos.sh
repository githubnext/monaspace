#!/bin/bash

# remove all fonts from ~/Library/Fonts that start with "Monaspace"
rm -rf ~/Library/Fonts/Monaspace*

# copy static fonts from ./otf to ~/Library/Fonts
cp ./fonts/otf/* ~/Library/Fonts

# copy variable fonts from ./variable to ~/Library/Fonts
cp ./fonts/variable/* ~/Library/Fonts

# copy frozen fonts from ./frozen to ~/Library/Fonts
cp ./fonts/frozen/* ~/Library/Fonts