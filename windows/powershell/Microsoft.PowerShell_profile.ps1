# XDG paths so cross-platform tools (nvim, etc.) find configs under ~/.config
$env:XDG_CONFIG_HOME = "$HOME\.config"
$env:XDG_DATA_HOME = "$HOME\.local\share"
$env:XDG_STATE_HOME = "$HOME\.local\state"
$env:XDG_CACHE_HOME = "$HOME\.cache"

# Some ported *nix tools look for HOME rather than USERPROFILE
$env:HOME = $HOME

$env:EDITOR = "nvim"
$env:VISUAL = "nvim"
$env:KUBE_EDITOR = "nvim"
$env:K9S_EDITOR = "nvim"

# Sensitive env vars (gitignored, see common/config/secrets/)
$secretsFile = "$HOME\.config\secrets\secrets.env"
if (Test-Path $secretsFile) {
    Get-Content $secretsFile | ForEach-Object {
        if ($_ -match '^\s*(#|$)') { return }
        $key, $value = $_ -split '=', 2
        [Environment]::SetEnvironmentVariable($key, $value, "Process")
    }
}

# Starship
Invoke-Expression (&starship init powershell)

# Aliases
function nv { nvim @args }
function ll { Get-ChildItem -Force @args }
function gst { git status @args }
function tf { terraform @args }
function kb { kubectl @args }
function kbc { kubectl config @args }
function kctx { kubectx @args }
function ctx { kubectx @args }
function q { exit }
Set-Alias -Name c -Value claude

function pbcopy { $input | Set-Clipboard }
function pbpaste { Get-Clipboard }
