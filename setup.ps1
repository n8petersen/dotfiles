#Requires -Version 7

$BaseDir = $PSScriptRoot

function Test-SymlinkSupport {
    $probeTarget = Join-Path $env:TEMP "dotfiles-symlink-probe-$PID"
    $probeLink = Join-Path $env:TEMP "dotfiles-symlink-probe-$PID-link"
    Set-Content -Path $probeTarget -Value "" -Force
    try {
        New-Item -ItemType SymbolicLink -Path $probeLink -Target $probeTarget -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    } finally {
        Remove-Item -Path $probeTarget -Force -ErrorAction SilentlyContinue
        Remove-Item -Path $probeLink -Force -ErrorAction SilentlyContinue
    }
}

function Get-ExistingItemKind {
    param([string]$Path)

    $item = Get-Item -Path $Path -Force
    if ($item.LinkType) { return "symlink" }
    return "real"
}

function Link-Files {
    param(
        [string]$SrcDir,
        [string]$TargetDir
    )

    if (-not (Test-Path $SrcDir)) { return }

    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

    Get-ChildItem -Force -Path $SrcDir | ForEach-Object {
        if ($_.Extension -eq ".md") { return }

        $target = Join-Path $TargetDir $_.Name

        if (Test-Path -Path $target) {
            if ((Get-ExistingItemKind $target) -eq "symlink") {
                Write-Host "Skipping existing symlink: $target"
            } else {
                Write-Host "Skipping existing file or directory: $target"
            }
        } else {
            New-Item -ItemType SymbolicLink -Path $target -Target $_.FullName | Out-Null
            Write-Host "Created symlink: $target -> $($_.FullName)"
        }
    }
}

function Link-SingleFile {
    param(
        [string]$SrcFile,
        [string]$TargetPath
    )

    if (-not (Test-Path $SrcFile)) { return }

    New-Item -ItemType Directory -Force -Path (Split-Path $TargetPath -Parent) | Out-Null

    if (Test-Path -Path $TargetPath) {
        if ((Get-ExistingItemKind $TargetPath) -eq "symlink") {
            Write-Host "Skipping existing symlink: $TargetPath"
        } else {
            Write-Host "Skipping existing file or directory: $TargetPath"
        }
    } else {
        New-Item -ItemType SymbolicLink -Path $TargetPath -Target $SrcFile | Out-Null
        Write-Host "Created symlink: $TargetPath -> $SrcFile"
    }
}

if (-not (Test-SymlinkSupport)) {
    Write-Host "Creating symlinks requires either Developer Mode or an elevated (Administrator) shell."
    Write-Host "Enable it via Settings > Privacy & security > For developers > Developer Mode, then re-run this script."
    exit 1
}

# Profile-specific configs first so they take priority over common for overlapping dirs
Link-Files "$BaseDir\windows\home" $HOME
Link-Files "$BaseDir\windows\config" "$HOME\.config"

# Common (fills in everything not already linked by the profile)
Link-Files "$BaseDir\common\home" $HOME
Link-Files "$BaseDir\common\config" "$HOME\.config"

# PowerShell profile: single-file symlink into both PS7 (pwsh) and Windows PowerShell 5.1
# profile locations, since either host may launch it.
$profileSrc = "$BaseDir\windows\powershell\Microsoft.PowerShell_profile.ps1"
Link-SingleFile $profileSrc "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Link-SingleFile $profileSrc "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Windows Terminal settings: only the packaged (MSIX) install location is handled here,
# since the unpackaged/portable release is uncommon.
$terminalPackage = Get-ChildItem "$env:LOCALAPPDATA\Packages" -Filter "Microsoft.WindowsTerminal*" -ErrorAction SilentlyContinue |
    Select-Object -First 1
if ($terminalPackage) {
    Link-SingleFile "$BaseDir\windows\windows-terminal\settings.json" "$($terminalPackage.FullName)\LocalState\settings.json"
} else {
    Write-Host "Windows Terminal not found under $env:LOCALAPPDATA\Packages; skipping settings.json symlink."
}
