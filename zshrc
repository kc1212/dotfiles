
# enable command completion and coloured prompt
autoload -U compinit promptinit
compinit                       # command completion
promptinit                     # coloured prompt
 
# This will set the default prompt to the walters theme
prompt walters

alias pd="pushd" #use this with popd
# alias open xdg-open
# alias sicstus "rlwrap sicstus"
alias xterm="xterm -bg black -fg white"
alias ll="ls -lh"

# show cool archlinux logo
/usr/bin/archey
