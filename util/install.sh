#!/bin/bash

echo "Starting font installation process..."

# Get target root directory
if [[ $(uname) == 'Darwin' ]]; then
    # MacOS
    sys_share_dir="/Library"
    usr_share_dir="$HOME/Library"
    font_subdir="Fonts"
    echo "Detected MacOS. Setting directories accordingly."
else
    # Linux
    sys_share_dir="/usr/local/share"
    usr_share_dir="$HOME/.local/share"
    font_subdir="fonts"
    echo "Detected Linux. Setting directories accordingly."
fi
if [ -n "${XDG_DATA_HOME}" ]; then
    usr_share_dir="${XDG_DATA_HOME}"
    echo "Using XDG_DATA_HOME as the user share directory."
fi

# Function to delete and copy fonts for macOS
install_fonts_mac() {
    echo "Removing existing Monaspace fonts from ${usr_share_dir}/${font_subdir}..."
    rm -rf ${usr_share_dir}/${font_subdir}/Monaspace*

    echo "Copying new fonts to ${usr_share_dir}/${font_subdir}..."
    cp ../fonts/otf/* ${usr_share_dir}/${font_subdir}
    cp ../fonts/variable/* ${usr_share_dir}/${font_subdir}

    echo "Fonts successfully installed for MacOS."
}

# Function to delete and copy fonts for Linux
install_fonts_linux() {
    echo "Ensuring font directory exists at ${usr_share_dir}/${font_subdir}..."
    mkdir -p ${usr_share_dir}/${font_subdir}

    echo "Removing existing Monaspace fonts from ${usr_share_dir}/${font_subdir}..."
    rm -rf ${usr_share_dir}/${font_subdir}/Monaspace*

    echo "Copying new fonts..."
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    cp $SCRIPT_DIR/../fonts/otf/* ${usr_share_dir}/${font_subdir}
    cp $SCRIPT_DIR/../fonts/variable/* ${usr_share_dir}/${font_subdir}

    echo "Rebuilding font information caches..."
    fc-cache -f

    echo "Fonts successfully installed for Linux."
}

# Detect the operating system and install fonts
OS="$(uname)"
if [ "$OS" == "Darwin" ]; then
    install_fonts_mac
elif [ "$OS" == "Linux" ]; then
    install_fonts_linux
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

echo "Font installation process completed."
