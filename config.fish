## Environment variables and PATH
# general
set -x EDITOR nvim

## nix
if test -L "$HOME/.nix-profile"
	source $HOME/.config/fish/nix.fish
end

# rust
set -gx RUST_SRC_PATH $HOME/rustcode/rust/src
set --universal fish_user_paths $fish_user_paths $HOME/.cargo/bin

# golang
set -gx GOPATH $HOME/gocode
set --universal fish_user_paths $fish_user_paths $GOPATH/bin

# stack (local bin)
set --universal fish_user_paths $fish_user_paths $HOME/.local/bin

## Aliases
alias cp 'cp -i'
alias mv 'mv -i'
alias ln 'ln -i'
alias chown 'chown --preserve-root'
alias chmod 'chmod --preserve-root'
alias chgrp 'chgrp --preserve-root'
alias tmux 'tmux -2'
