#!/bin/bash

# Monaspace Release Artifacts Preparation Script
# This script creates zip files for each font category to be attached to GitHub releases

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
FONTS_DIR="fonts"
OUTPUT_DIR="./release-artifacts"
VERSION=${1:-"1.3"}

echo -e "${GREEN}Monaspace Release Artifacts Generator${NC}"
echo -e "Version: ${YELLOW}${VERSION}${NC}"
echo ""

# Check if fonts directory exists
if [ ! -d "$FONTS_DIR" ]; then
    echo -e "${RED}Error: fonts directory not found at $FONTS_DIR${NC}"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"
rm -rf "$OUTPUT_DIR"/*

echo -e "${YELLOW}Preparing release artifacts...${NC}"

# Function to create zip file for a directory
create_zip() {
    local source_dir="$1"
    local zip_name="$2"
    local parent_dir="${3:-$FONTS_DIR}"
    local full_path="$parent_dir/$source_dir"
    
    if [ -d "$full_path" ]; then
        echo "  Creating $zip_name from $full_path"
        if [ "$parent_dir" = "$FONTS_DIR" ]; then
            (cd "$parent_dir" && zip -r "../$OUTPUT_DIR/$zip_name" "$source_dir") > /dev/null
        else
            (cd "$parent_dir" && zip -r "../../$OUTPUT_DIR/$zip_name" "$source_dir") > /dev/null
        fi
        
        # Get file count and size
        local file_count=$(find "$full_path" -type f | wc -l | tr -d ' ')
        local zip_size=$(ls -lh "$OUTPUT_DIR/$zip_name" | awk '{print $5}')
        echo "    ✓ $file_count files, $zip_size"
    else
        echo -e "    ${RED}Warning: Directory '$source_dir' not found${NC}"
    fi
}

# Create zip files for each font category
create_zip "Static Fonts" "monaspace-static-v${VERSION}.zip"
create_zip "Variable Fonts" "monaspace-variable-v${VERSION}.zip"
create_zip "Frozen Fonts" "monaspace-frozen-v${VERSION}.zip"
create_zip "NerdFonts" "monaspace-nerdfonts-v${VERSION}.zip"

# Handle webfonts separately with directory change
if [ -d "$FONTS_DIR/Web Fonts" ]; then
    echo -e "${YELLOW}Processing web fonts...${NC}"
    
    # Create zips from within Web Fonts directory
    create_zip "NerdFonts Web Fonts" "monaspace-webfont-nerdfonts-v${VERSION}.zip" "$FONTS_DIR/Web Fonts"
    create_zip "Static Web Fonts" "monaspace-webfont-static-v${VERSION}.zip" "$FONTS_DIR/Web Fonts"
    create_zip "Variable Web Fonts" "monaspace-webfont-variable-v${VERSION}.zip" "$FONTS_DIR/Web Fonts"
else
    echo -e "${RED}Warning: Web Fonts directory not found${NC}"
fi

echo ""
echo -e "${GREEN}Release artifacts created in: ${OUTPUT_DIR}${NC}"
echo ""

# List all created files
if [ -d "$OUTPUT_DIR" ] && [ "$(ls -A $OUTPUT_DIR)" ]; then
    echo "Generated files:"
    ls -lh "$OUTPUT_DIR"/*.zip | while read -r line; do
        filename=$(echo "$line" | awk '{print $9}' | xargs basename)
        size=$(echo "$line" | awk '{print $5}')
        echo "  - $filename ($size)"
    done
else
    echo -e "${RED}No artifacts were created${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✓ Release preparation complete!${NC}"
echo -e "Upload these files as release assets to GitHub."