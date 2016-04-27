# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
else
    echo 'Cannot find /etc/bashrc!'
fi

###############################################################################
###############################################################################
###############################################################################

# environment variables, $TERM is included
if [ -f ~/.bash_env ]; then
  source ~/.bash_env
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi

# disabled seahorse-ssh-askpass
# http://kartzontech.blogspot.co.uk/2011/04/how-to-disable-gnome-ssh-askpass.html
# unset SSH_ASKPASS

# for nix
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi


