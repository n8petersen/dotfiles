if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable Greeting
set -U fish_greeting ""

# Enable starship
starship init fish | source

# macOS specific
if test (uname) = Darwin
    eval (/opt/homebrew/bin/brew shellenv)
    fish_add_path ~/.opencode/bin
    alias o="opencode"
end

# Configure env vars
set SSH_AUTH_SOCK ~/.1password/agent.sock
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx KUBE_EDITOR nvim
set -gx K9S_EDITOR nvim

# Configure aliases
alias clr "printf '\033[2J\033[3J\033[1;1H'"
alias ll "ls -lah"
alias nv='nvim'
alias gst='git status'
alias tf='terraform'
alias kb='kubectl'
alias kbc='kubectl config'
alias kssh='kitty +kitten ssh'
alias kctx="kubectx"
alias ctx="kubectx"
alias q='exit'
alias :q='exit'
alias c="claude"

fish_add_path $HOME/.local/bin
