# dotfiles

Nate's dotfiles. Supports Arch Linux, CachyOS, and macOS.

## Structure

```
common/      # Shared across all profiles (fish, nvim, kitty, starship, git, etc.)
arch/        # Arch / CachyOS
arch-hypr/   # Arch + Hyprland
mac/         # macOS
```

`setup.sh` always links `common/`, then links the selected profile on top.

## Setup

### 1. Clone
```bash
git clone git@github.com:n8petersen/dotfiles.git ~/.dotfiles
```

> On a new machine without SSH keys configured, clone via HTTPS first:
> ```bash
> git clone https://github.com/n8petersen/dotfiles.git ~/.dotfiles
> ```

### 2. Run setup
```bash
cd ~/.dotfiles && ./setup.sh
```

- **macOS**: auto-detected. Installs Homebrew and CaskaydiaMono Nerd Font if missing, then links configs.
- **Linux**: prompts for a profile:
  - `[1] arch` — Arch / CachyOS
  - `[2] arch-hypr` — Arch + Hyprland

### 3. Install packages

See the profile README for package lists:
- [arch](arch/README.md)
- [arch-hypr](arch-hypr/README.md)
