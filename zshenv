# defaults
export EDITOR=vim
export CLICOLOR=TRUE

# ruby gem paths
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem
export PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin

if [[ $platform == 'linux' ]]; then
  # for ibus
  export GTK_IM_MODULE=ibus
  export XMODIFIERS=@im=ibus
  export QT_IM_MODULE=ibus

  # 32bit wine, need to use winecfg, archlinux specific
  export WINEARCH=win32
  export WINEPREFIX=~/.wine

elif [[ $platform == 'darwin' ]]; then
  # for python (mac only)
  export PATH=/usr/local/share/python:$PATH

fi
