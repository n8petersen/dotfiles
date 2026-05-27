# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Public repo

This is a public GitHub repository. Do not add personal information (home addresses, phone numbers, private email addresses) or any credentials (API keys, tokens, passwords, private SSH keys) to any tracked file. Check `.gitignore` files before staging anything under `common/home/.claude/` or profile dirs.

## What this repo is

A dotfiles repo using a profile-based symlink system. `setup.sh` creates symlinks from the repo into `$HOME` and `$HOME/.config`. There are no build steps, tests, or linters.

## Running setup

```bash
./setup.sh
```

- **macOS**: auto-detected; installs Homebrew and CaskaydiaMono Nerd Font if missing
- **Linux**: prompts `[1] arch` or `[2] arch-hypr`

## Structure

```
common/      # Symlinked on every machine
  home/      # → ~/
  config/    # → ~/.config/
arch/        # Arch / CachyOS additions
arch-hypr/   # Arch + Hyprland additions
mac/         # macOS additions
```

Profile dirs are linked first; `common/` fills in everything not already linked. This means a file in `arch/config/fish/` takes priority over `common/config/fish/` on arch machines.

## How symlinks work

`link_files src target` iterates the top level of `src` and creates one symlink per item in `target`. It skips `.md` files, existing symlinks (🔵), and existing real files/dirs (🟡). Symlinks are created at the **directory** level — e.g. `~/.config/fish` → `dotfiles/common/config/fish`, not individual files within it.

This means: if both `common/config/fish/` and a profile's `config/fish/` exist, they conflict. Put shared content in `common/` and per-profile content in the profile dir under a **different name** (e.g. a `conf.d/` file), or put the full config only in the profile dir.

## Key things tracked

- `common/home/.claude/` — Claude Code settings and plugins (credentials, sessions, cache are gitignored via `common/home/.claude/.gitignore`)
- `common/config/fish/config.fish` — includes an OS detection block for macOS-specific brew/opencode setup
- `common/home/.gitconfig` — includes `[include] path = .gitconfig.local` for machine-local overrides (not tracked)

## Adding a new profile

1. Create `<profile>/home/` and/or `<profile>/config/` with the relevant configs
2. Add it as a numbered option in the `case` block in `setup.sh`
