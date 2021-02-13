#/usr/bin/env bash

function dotfiles {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

git clone --bare git@github.com:kc1212/dotfiles.git $HOME/.cfg

pushd "$HOME"

dotfiles checkout
if [ $? = 0 ]; then
    echo "Checked out dotfiles."
else
    echo "Backing up pre-existing dot files."
    dotfiles checkout 2>&1 | egrep "^\s" | sed 's/^\s*//g' | parallel --will-cite 'mkdir -p dotfiles-backup/{//}; mv {} dotfiles-backup/{}'
fi;
dotfiles checkout
if [ $? != 0 ]; then
    echo "Backup failed."
    exit 1
fi;
dotfiles config status.showUntrackedFiles no
echo "Done."

popd
