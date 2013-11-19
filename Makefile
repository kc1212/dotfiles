all:
	# update the submodules
	cd ~/dotfiles; git submodule init; git submodule update

vim:
	# link vim files
	ln -s ~/dotfiles/vim/ ~/.vim
	ln -s ~/dotfiles/vimrc ~/.vimrc
	ln -s ~/dotfiles/gvimrc ~/.gvimrc

bash:
	# link bash files
	ln -s ~/dotfiles/bashrc ~/.bashrc
	ln -s ~/dotfiles/bash_aliases ~/.bash_aliases
	ln -s ~/dotfiles/bash_logout ~/.bash_logout
	ln -s ~/dotfiles/shell_env ~/.shell_env

git:
	# link git files
	ln -s ~/dotfiles/gitconfig ~/.gitconfig
	ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

tmux:
	# tmux
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

	# note: place '/' at the end of path for directories
	# i.e. use ~/dotfiles/vim/ rather than ~/dotfiles/vim

clean:
	# nothing here
