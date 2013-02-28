#!/bin/bash

# update the submodules
cd ~/dotfiles
git submodule init
git submodule update

# link vim files
ln -s ~/dotfiles/vim/ ~/.vim
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/gvimrc ~/.gvimrc

# link zsh files
ln -s ~/dotfiles/oh-my-zsh/ ~/.oh-my-zsh
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/zshenv ~/.zshenv

# link git files
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

# notes
# user "/" for directories, e.g. !/dotfiles/vim/
# install solarized theme to iterm2
