#!/usr/bin/env bash

set -euo pipefail

origin=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) || exit

input_dir="${origin}/../fonts"
fonts_dir="${HOME}/.local/share/fonts"

# ensure that ~/.local/share/fonts exists
mkdir -p "${fonts_dir}"

# remove all fonts from ~/.local/share/fonts that start with "Monaspace"
rm -rf "${fonts_dir}/"Monaspace*

mkdir -p "${fonts_dir}/Monaspace/"

# copy all fonts from ./otf to ~/.local/share/fonts
cp "${input_dir}/otf/"* "${fonts_dir}/Monaspace/"

# copy variable fonts from ./variable to ~/.local/share/fonts
cp "${input_dir}/variable/"* "${fonts_dir}/Monaspace/"

# Build font information caches
fc-cache -f
