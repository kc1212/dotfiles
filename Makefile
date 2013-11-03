all:
	# update the submodules
	cd ~/dotfiles; git submodule init; git submodule update

	# link vim files	
	ln -s ~/dotfiles/vim/ ~/.vim
	ln -s ~/dotfiles/vimrc ~/.vimrc
	ln -s ~/dotfiles/gvimrc ~/.gvimrc

	# link bash files
	ln -s ~/dotfiles/bashrc ~/.bashrc
	ln -s ~/dotfiles/bash_aliases ~/.bash_aliases
	ln -s ~/dotfiles/bash_logout ~/.bash_logout
	ln -s ~/dotfiles/shell_env ~/.shell_env

	# link git files
	ln -s ~/dotfiles/gitconfig ~/.gitconfig
	ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

	# tmux
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

	# note: place '/' at the end of path for directories
	# i.e. use ~/dotfiles/vim/ rather than ~/dotfiles/vim

xmonad:
	# xmonad files
	ln -s ~/dotfiles/xmonad ~/.xmonad
	ln -s ~/dotfiles/Xresources ~/.Xresources

crunchbang:
	# crunchbang settings
	ln -s ~/dotfiles/crunchbang/openbox/ ~/.config/openbox
	ln -s ~/dotfiles/crunchbang/tint2/ ~/.config/tint2
	ln -s ~/dotfiles/crunchbang/dmenu/ ~/.config/dmenu
	ln -s ~/dotfiles/crunchbang/Thunar/ ~/.config/Thunar
	ln -s ~/dotfiles/crunchbang/nitrogen/ ~/.config/nitrogen

clean:
	# nothing here
