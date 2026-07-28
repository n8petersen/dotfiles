# dotfiles

Nate's dotfiles. Supports Arch Linux, CachyOS, macOS, and Windows.

## Structure

```
common/      # Shared across all profiles (fish, nvim, kitty, starship, git, etc.)
arch/        # Arch / CachyOS
arch-hypr/   # Arch + Hyprland
mac/         # macOS
windows/     # Windows (PowerShell, native — not WSL)
```

`setup.sh` (macOS/Linux) or `setup.ps1` (Windows) always links `common/`, then links the selected profile on top.

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

macOS/Linux:
```bash
cd ~/.dotfiles && ./setup.sh
```
- **macOS**: auto-detected. Installs Homebrew and CaskaydiaMono Nerd Font if missing, then links configs.
- **Linux**: prompts for a profile:
  - `[1] arch` — Arch / CachyOS
  - `[2] arch-hypr` — Arch + Hyprland

Windows (PowerShell 7+, run from `~/.dotfiles`):
```powershell
.\setup.ps1
```
Requires Developer Mode (or an elevated shell) so `New-Item -ItemType SymbolicLink` can create symlinks. See [windows](windows/README.md) for details.

### 3. Install packages

See the profile README for package lists:
- [arch](arch/README.md)
- [arch-hypr](arch-hypr/README.md)
- [windows](windows/README.md)
