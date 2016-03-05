
# TODO create a function that does backup and symbolic link

.PHONY: all vimplug vim bash git tmux resources ctags haskell nix clean_backup

REPODIR := ~/dotfiles/

all: vim bash git tmux resources ctags

vimplug:
	curl -fLo $(REPODIR)vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim: vimplug
	$(REPODIR)scripts/do_backup ~/.vim
	$(REPODIR)scripts/do_backup ~/.vimrc
	$(REPODIR)scripts/do_backup ~/.gvimrc
	ln -s $(REPODIR)vim ~/.vim
	ln -s $(REPODIR)vimrc ~/.vimrc
	ln -s $(REPODIR)gvimrc ~/.gvimrc

nvim: vimplug
	$(REPODIR)scripts/do_backup ~/.nvim
	$(REPODIR)scripts/do_backup ~/.nvimrc
	ln -s $(REPODIR)vim ~/.nvim
	ln -s $(REPODIR)vimrc ~/.nvimrc

bash:
	$(REPODIR)scripts/do_backup ~/.bashrc
	$(REPODIR)scripts/do_backup ~/.bash_aliases
	$(REPODIR)scripts/do_backup ~/.bash_logout
	$(REPODIR)scripts/do_backup ~/.bash_profile
	$(REPODIR)scripts/do_backup ~/.bash_env
	ln -s $(REPODIR)bashrc ~/.bashrc
	ln -s $(REPODIR)bash_aliases ~/.bash_aliases
	ln -s $(REPODIR)bash_logout ~/.bash_logout
	ln -s $(REPODIR)bash_profile ~/.bash_profile
	ln -s $(REPODIR)bash_env ~/.bash_env

git:
	$(REPODIR)scripts/do_backup ~/.gitconfig
	$(REPODIR)scripts/do_backup ~/.gitignore_global
	# note the cp instead of ln -s
	cp $(REPODIR)gitconfig ~/.gitconfig
	cp $(REPODIR)gitignore_global ~/.gitignore_global

tmux:
	$(REPODIR)scripts/do_backup ~/.tmux.conf
	ln -s $(REPODIR)tmux.conf ~/.tmux.conf

resources:
	# note: place '/' at the end of path for directories
	# i.e. use $(REPODIR)vim/ rather than $(REPODIR)vim
	$(REPODIR)scripts/do_backup ~/.Xresources
	ln -s $(REPODIR)Xresources ~/.Xresources
	xrdb ~/.Xresources

ctags:
	$(REPODIR)scripts/do_backup ~/.ctags
	ln -s $(REPODIR)ctags ~/.ctags

haskell:
	$(REPODIR)scripts/do_backup ~/.ghci
	ln -s $(REPODIR)ghci ~/.ghci

nix:
	$(REPODIR)scripts/do_backup ~/.nixpkgs
	ln -s $(REPODIR)nixpkgs ~/.nixpkgs


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



