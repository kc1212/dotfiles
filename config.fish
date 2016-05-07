## Environment variables and PATH
# general
set -x EDITOR nvim

## nix
if test -L "$HOME/.nix-profile"
	source $HOME/.config/fish/nix.fish
end

# rust
set -x RUST_SRC_PATH $HOME/rustcode/rust/src
set PATH $PATH $HOME/.cargo/bin

# golang
set -x GOPATH $HOME/gocode
set PATH $PATH $GOPATH/bin

# stack (local bin)
set PATH $PATH $HOME/.local/bin


## Aliases
alias cp 'cp -i'
alias mv 'mv -i'
alias ln 'ln -i'
alias chown 'chown --preserve-root'
alias chmod 'chmod --preserve-root'
alias chgrp 'chgrp --preserve-root'
alias tmux 'tmux -2'
