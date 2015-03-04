
.PHONY: all submodule vim bash git tmux resources ctags clean_backup

all: vim bash git tmux resources ctags

submodule:
	cd ~/dotfiles && git submodule init && git submodule update

vim: submodule
	~/dotfiles/scripts/do_backup ~/.vim
	~/dotfiles/scripts/do_backup ~/.vimrc
	~/dotfiles/scripts/do_backup ~/.gvimrc
	ln -s ~/dotfiles/vim ~/.vim
	ln -s ~/dotfiles/vimrc ~/.vimrc
	ln -s ~/dotfiles/gvimrc ~/.gvimrc
	# vim +PluginInstall +qall


bash:
	~/dotfiles/scripts/do_backup ~/.bashrc
	~/dotfiles/scripts/do_backup ~/.bash_aliases
	~/dotfiles/scripts/do_backup ~/.bash_logout
	~/dotfiles/scripts/do_backup ~/.bash_profile
	~/dotfiles/scripts/do_backup ~/.bash_env
	ln -s ~/dotfiles/bashrc ~/.bashrc
	ln -s ~/dotfiles/bash_aliases ~/.bash_aliases
	ln -s ~/dotfiles/bash_logout ~/.bash_logout
	ln -s ~/dotfiles/bash_profile ~/.bash_profile
	ln -s ~/dotfiles/bash_env ~/.bash_env

git:
	~/dotfiles/scripts/do_backup ~/.gitconfig
	~/dotfiles/scripts/do_backup ~/.gitignore_global
	# note the cp instead of ln -s
	cp ~/dotfiles/gitconfig ~/.gitconfig
	cp ~/dotfiles/gitignore_global ~/.gitignore_global

tmux:
	~/dotfiles/scripts/do_backup ~/.tmux.conf
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

resources:
	# note: place '/' at the end of path for directories
	# i.e. use ~/dotfiles/vim/ rather than ~/dotfiles/vim
	~/dotfiles/scripts/do_backup ~/.Xresources
	ln -s ~/dotfiles/Xresources ~/.Xresources
	xrdb ~/.Xresources

ctags:
	~/dotfiles/scripts/do_backup ~/.ctags
	ln -s ~/dotfiles/ctags ~/.ctags


clean_backup:
	rm -rf ~/.vim.bak
	rm -f ~/.vimrc.bak
	rm -f ~/.gvimrc.bak
	rm -f ~/.bashrc.bak
	rm -f ~/.bash_aliases.bak
	rm -f ~/.bash_logout.bak
	rm -f ~/.bash_profile.bak
	rm -f ~/.bash_env.bak
	rm -f ~/.gitconfig.bak
	rm -f ~/.gitignore_global.bak
	rm -f ~/.tmux.conf.bak
	rm -f ~/.Xresources.bak
	rm -f ~/.ctags.bak



