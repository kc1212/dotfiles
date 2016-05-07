#!/usr/bin/env bash

set -e
set -u

# generic installation, the convention is ln -s $REPODIR/$file ~/.$file
ln_files="vimrc bashrc bash_aliases bash_logout bash_env bash_profile tmux.conf Xresources ctags ghci nixpkgs"
cp_files="gitconfig gitignore_global"
REPODIR=~/dotfiles

function do_backup()
{
    if [ $# -eq 0 ]
    then
        echo "at least one argument is required"
        exit 1
    fi

    local f=$1

    if [ -f "$f" ] || [ -d "$f" ]
    then
        mv "$f"{,.bak}
        echo "backup performed on $f"
    fi
}

function install_dotfiles()
{
    # create symlink
    for f in $ln_files; do
        do_backup "$HOME/.$f"
        ln -sf "$REPODIR/$f" "$HOME/.$f"
    done

    # create copies
    for f in $cp_files; do
        do_backup "$HOME/.$f"
        cp "$REPODIR/$f" "$HOME/.$f"
    done

    # neovim stuff, download to $vim_plug, then copy to nvim directory
    # TODO there should be a way to delete/uninstall these too
    vim_plug=~/.vim/autoload/plug.vim
    curl -fLo $vim_plug --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    mkdir -p ~/.config/nvim/autoload && cp $vim_plug "$_"
    ln -s $REPODIR/vimrc ~/.config/nvim/init.vim

    # zathura
    # TODO
}

function delete_backup()
{
    for f in $ln_files $cp_files; do
        rm -f "$HOME/.$f.bak"
    done
}

function delete_links()
{
    for f in $ln_files; do
        if [[ -L $HOME/.$f ]]; then
            rm -f "$HOME/.$f"
        else
            echo "$HOME/.$f is not a symlink!"
            exit 1
        fi
    done
}

# TODO parse arguments
# delete_backup
install_dotfiles
# delete_links
