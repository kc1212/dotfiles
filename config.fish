## Environment variables and PATH

# editor
set -xg EDITOR nvim

# nix
if test -L "$HOME/.nix-profile"
	source $HOME/.config/fish/nix.fish
end

# rust
set -xg RUST_SRC_PATH $HOME/rustcode/rust/src
set fish_user_paths $fish_user_paths $HOME/.cargo/bin

# golang
set -xg GOPATH $HOME/gocode
set fish_user_paths $fish_user_paths $GOPATH/bin

# stack (local bin)
set fish_user_paths $fish_user_paths $HOME/.local/bin

# aliases
alias cp 'cp -i'
alias mv 'mv -i'
alias ln 'ln -i'
alias chown 'chown --preserve-root'
alias chmod 'chmod --preserve-root'
alias chgrp 'chgrp --preserve-root'
alias tmux 'tmux -2'
