#!/usr/bin/env bash

set -euo pipefail

origin=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) || exit

input_dir="${origin}/../fonts"
fonts_dir="${HOME}/Library/Fonts"

# remove all fonts from ~/Library/Fonts that start with "Monaspace"
rm -rf "${fonts_dir}"/Monaspace*

# copy all fonts from ./otf to ~/Library/Fonts
cp "${input_dir}/otf/"* "${fonts_dir}"

# copy variable fonts from ./variable to ~/Library/Fonts
cp "${input_dir}/variable/"* "${fonts_dir}"