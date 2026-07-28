alias nv='nvim'
alias ll='ls -la'
alias gst='git status'
alias tf='terraform'
alias kb='kubectl'
alias kbc='kubectl config'
alias parupdate='paru -Syu --noconfirm'
alias p='paru -Syu --noconfirm'

case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*)
        # Git Bash's bundled ssh (MSYS2 build) fails on some keys with
        # "error in libcrypto: unsupported"; the native Windows OpenSSH
        # client handles them fine. kitty isn't available on Windows.
        alias ssh='/c/Windows/System32/OpenSSH/ssh.exe'
        ;;
    *)
        alias ssh='kitty +kitten ssh'
        ;;
esac
