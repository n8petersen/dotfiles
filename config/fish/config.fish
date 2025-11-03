if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable Greeting
set -U fish_greeting ""

# Enable starship
starship init fish | source

# Enable brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Configure env vars
set SSH_AUTH_SOCK ~/.1password/agent.sock

# Configure aliases
alias clr "printf '\033[2J\033[3J\033[1;1H'"
alias ll "ls -lah"
alias kb kubectl
alias nv='nvim'
alias gst='git status'
alias tf='terraform'
alias kb='kubectl'
alias kbc='kubectl config'
alias ssh='kitty +kitten ssh'
