# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

# 32bit wine, need to use winecfg
export WINEARCH=win32
export WINEPREFIX=~/.wine

# disabled seahorse-ssh-askpass
# http://kartzontech.blogspot.co.uk/2011/04/how-to-disable-gnome-ssh-askpass.html
unset SSH_ASK_PASS

alias pd="pushd" #use this with popd
# alias open xdg-open
# alias sicstus "rlwrap sicstus"
alias xterm="xterm -bg black -fg white"
alias ll="ls -lh"

# show cool archlinux logo
# /usr/bin/archey

# this fixed the ctrl-a ctrl-e bug, taken from
# http://superuser.com/questions/523564/emacs-keybindings-in-zsh-not-working-ctrl-a-ctrl-e 
bindkey -e
