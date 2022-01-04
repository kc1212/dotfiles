# .bashrc

PROMPT_DIRTRIM=2

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

###############################################################################
###############################################################################
###############################################################################

# Environment variables
if [ -f ~/.bash_env ]; then
  source ~/.bash_env
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Terminal color
if [ -f ~/.dircolors ]; then
    eval $(dircolors ~/.dircolors)
fi

# Nix
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi


