#!/bin/bash

# Get the absolute path of the current script's directory
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to create symlinks
link_files() {
    local src_dir=$1
    local target_dir=$2

    mkdir -p "$target_dir"

    for item in "$src_dir"/*; do
        local base_item=$(basename "$item")
        local target="$target_dir/$base_item"

        if [ -L "$target" ]; then
            echo "Skipping existing symlink: $target"
        elif [ -e "$target" ]; then
            echo "Skipping existing file or directory: $target"
        else
            ln -s "$item" "$target"
            echo "Created symlink: $target -> $item"
        fi
    done
}

# Link files from ./home to ~/
link_files "$BASE_DIR/home" "$HOME"

# Link files from ./config to ~/.config
link_files "$BASE_DIR/config" "$HOME/.config"

