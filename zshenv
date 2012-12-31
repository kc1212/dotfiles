###################### DEFAULTS ##############################################

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


####################### ALIASES ##############################################

alias pd="pushd" #use this with popd
# alias open xdg-open
# alias sicstus "rlwrap sicstus"
alias xterm="xterm -bg black -fg white"
alias ll="ls -lh"

