#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Starship
eval "$(starship init bash)"
starship preset gruvbox-rainbow -o ~/.config/starship.toml
# export STARSHIP_CONFIG=~/config/starship.toml
#
source ~/.bash_aliases
