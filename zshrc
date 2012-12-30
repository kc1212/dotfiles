
# enable command completion
autoload -U compinit
compinit

# enable coloured prompt
autoload -U promptinit
promptinit
prompt walters # use walters theme

# for ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# defaults
export EDITOR=vim

alias pd="pushd" #use this with popd
# alias open xdg-open
# alias sicstus "rlwrap sicstus"
alias xterm="xterm -bg black -fg white"
alias ll="ls -lh"

# show cool archlinux logo
# /usr/bin/archey
