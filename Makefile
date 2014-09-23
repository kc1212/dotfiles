all: lvim lbash lgit ltmux lresources lctags
	# do everything other than submodule

submodule:
	cd ~/dotfiles && git submodule init && git submodule update

lvim:
	~/dotfiles/do_backup ~/.vim
	~/dotfiles/do_backup ~/.vimrc
	~/dotfiles/do_backup ~/.gvimrc
	ln -s ~/dotfiles/vim ~/.vim
	ln -s ~/dotfiles/vimrc ~/.vimrc
	ln -s ~/dotfiles/gvimrc ~/.gvimrc
	# vim +PluginInstall +qall


lbash:
	~/dotfiles/do_backup ~/.bashrc
	~/dotfiles/do_backup ~/.bash_aliases
	~/dotfiles/do_backup ~/.bash_logout
	~/dotfiles/do_backup ~/.bash_profile
	~/dotfiles/do_backup ~/.bash_env
	ln -s ~/dotfiles/bashrc ~/.bashrc
	ln -s ~/dotfiles/bash_aliases ~/.bash_aliases
	ln -s ~/dotfiles/bash_logout ~/.bash_logout
	ln -s ~/dotfiles/bash_profile ~/.bash_profile
	ln -s ~/dotfiles/bash_env ~/.bash_env

lgit:
	~/dotfiles/do_backup ~/.gitconfig
	~/dotfiles/do_backup ~/.gitignore_global
	ln -s ~/dotfiles/gitconfig ~/.gitconfig
	ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

ltmux:
	~/dotfiles/do_backup ~/.tmux.conf
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

lresources:
	# note: place '/' at the end of path for directories
	# i.e. use ~/dotfiles/vim/ rather than ~/dotfiles/vim
	~/dotfiles/do_backup ~/.Xresources
	ln -s ~/dotfiles/Xresources ~/.Xresources
	xrdb ~/.Xresources

lctags:
	~/dotfiles/do_backup ~/.ctags
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



