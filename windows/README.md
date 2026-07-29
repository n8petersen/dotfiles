# windows profile

Config files specific to native Windows (PowerShell, not WSL).

## Setup

Symlinks require either Developer Mode or an elevated shell (`New-Item -ItemType SymbolicLink` needs one of the two). Enable Developer Mode via Settings > Privacy & security > For developers, then:

```powershell
cd ~\.dotfiles
.\setup.ps1
```

This links:
- `windows/home` and `common/home` into `$HOME`
- `windows/config` and `common/config` into `$HOME\.config` (nvim, starship, etc. read from here)
- the PowerShell profile into both the PS7 (`Documents\PowerShell`) and Windows PowerShell 5.1 (`Documents\WindowsPowerShell`) profile locations
- Windows Terminal's `settings.json`, if the packaged (MSIX) install is found under `%LOCALAPPDATA%\Packages`

kitty and fish aren't included — neither has real native Windows support. Windows Terminal + PowerShell stand in for them.

## Packages

Install via [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/):

```powershell
winget install --id Neovim.Neovim
winget install --id Starship.Starship
winget install --id Git.Git
winget install --id GitHub.cli
winget install --id AgileBits.1Password
winget install --id AgileBits.1Password.CLI
winget install --id Microsoft.WindowsTerminal
winget install --id Microsoft.PowerShell
winget install --id junegunn.fzf
winget install --id sxyazi.yazi
winget install --id dandavison.delta
```

CaskaydiaMono Nerd Font (matches the font face already set in `windows/windows-terminal/settings.json` and the glyphs in `common/config/starship.toml`) isn't on winget; install via [Chocolatey](https://chocolatey.org/):

```powershell
choco install nerd-fonts-CascadiaMono
```

A C compiler is needed for `nvim-treesitter` to build parsers (not required on macOS/Linux, which usually have one preinstalled):

```powershell
winget install --id BrechtSanders.WinLibs.POSIX.UCRT
```
