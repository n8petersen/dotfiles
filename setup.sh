#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link_files() {
    local src_dir=$1
    local target_dir=$2

    [ -d "$src_dir" ] || return 0

    mkdir -p "$target_dir"
    shopt -s nullglob dotglob

    for item in "$src_dir"/* "$src_dir"/.[!.]* "$src_dir"/..?*; do
        if [[ "$item" == *.md ]]; then
            continue
        fi

        local base_item=$(basename "$item")
        local target="$target_dir/$base_item"

        if [ -L "$target" ]; then
            echo "🔵 Skipping existing symlink: $target"
        elif [ -e "$target" ]; then
            echo "🟡 Skipping existing file or directory: $target"
        else
            ln -s "$item" "$target"
            echo "🟢 Created symlink: $target -> $item"
        fi
    done

    shopt -u nullglob dotglob
}

OS="$(uname -s)"

if [ "$OS" = "Darwin" ]; then
    PROFILE="mac"

    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    if ! brew list --cask font-caskaydia-mono-nerd-font &>/dev/null; then
        echo "Installing CaskaydiaMono Nerd Font..."
        brew install --cask font-caskaydia-mono-nerd-font
    fi

elif [ "$OS" = "Linux" ]; then
    echo "Select a profile:"
    echo "  [1] arch"
    echo "  [2] arch-hypr"
    read -rp "Profile [1-2]: " choice
    case "$choice" in
        1) PROFILE="arch" ;;
        2) PROFILE="arch-hypr" ;;
        *) echo "Invalid choice: $choice"; exit 1 ;;
    esac
else
    echo "Unsupported OS: $OS"
    exit 1
fi

echo "Using profile: $PROFILE"

# Link profile first so it takes priority over common for any overlapping dirs
link_files "$BASE_DIR/$PROFILE/home" "$HOME"
link_files "$BASE_DIR/$PROFILE/config" "$HOME/.config"

# Link common (fills in everything not already linked by the profile)
link_files "$BASE_DIR/common/home" "$HOME"
link_files "$BASE_DIR/common/config" "$HOME/.config"
