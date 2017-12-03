#
# ~/.bash_profile
#

# use bashrc when this file is used in an interactive shell
# taken from https://unix.stackexchange.com/questions/38402/aliases-and-tmux
case $- in *i*) [[ -f ~/.bashrc ]] && . ~/.bashrc;; esac

if [ -e /home/kc1212/.nix-profile/etc/profile.d/nix.sh ]; then . /home/kc1212/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
