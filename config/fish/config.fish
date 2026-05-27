if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable Greeting
set -U fish_greeting ""

# Enable starship
starship init fish | source

# Enable brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Configure env vars
set SSH_AUTH_SOCK ~/.1password/agent.sock
set EDITOR nvim
set VISUAL nvim
set KUBE_EDITOR nvim
set K9S_EDITOR nvim

# Configure aliases
alias clr "printf '\033[2J\033[3J\033[1;1H'"
alias ll "ls -lah"
alias kb kubectl
alias nv='nvim'
alias gst='git status'
alias tf='terraform'
alias kb='kubectl'
alias kbc='kubectl config'
alias kssh='kitty +kitten ssh'
alias kctx="kubectx"
alias q='exit'
alias :q='exit'
export PATH="$HOME/.local/bin:$PATH"
alias c="claude"
alias o="opencode"

# opencode
fish_add_path /Users/nate/.opencode/bin
