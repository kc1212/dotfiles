# detects operating system, creates variable $platform
source $HOME/dotfiles/detectOS

# defaults
export EDITOR=vim
export CLICOLOR=TRUE

# ruby gem paths and variables
export GEM_HOME=$HOME/.gem
export GEM_PATH=$GEM_HOME
export PATH=$HOME/.gem/ruby/1.9.1/bin:$PATH

if [[ $platform == 'linux' ]]; then
  # for ibus
  export GTK_IM_MODULE=ibus
  export XMODIFIERS=@im=ibus
  export QT_IM_MODULE=ibus

  # 32bit wine, need to use winecfg, archlinux specific
  export WINEARCH=win32
  export WINEPREFIX=~/.wine

elif [[ $platform == 'darwin' ]]; then

  # export PATH=/usr/gcc-4.7.2/bin:$PATH
  export PATH=/usr/local/share/python:$PATH
  export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
  export PATH=/usr/local/bin:$PATH


fi
