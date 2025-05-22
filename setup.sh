#!/bin/bash

# Get the absolute path of the current script's directory
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to create symlinks
link_files() {
    local src_dir=$1
    local target_dir=$2

    mkdir -p "$target_dir"

    # Enable globbing for dotfiles and avoid errors on no match
    shopt -s nullglob dotglob

    for item in "$src_dir"/* "$src_dir"/.[!.]* "$src_dir"/..?*; do
        # Skip if it's a .md file
        if [[ "$item" == *.md ]]; then
            echo "Skipping .md file: $item"
            continue
        fi

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

    shopt -u nullglob dotglob
}

# Link files from ./home to ~/
link_files "$BASE_DIR/home" "$HOME"

# Link files from ./config to ~/.config
link_files "$BASE_DIR/config" "$HOME/.config"

