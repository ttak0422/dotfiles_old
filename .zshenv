# TODO 
declare OS=($($HOME/dotfiles/bin/get_os))

# rbenv
if [[ -d $HOME/.rbenv ]]; then 
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

# pyenv
if [[ -d $HOME/.pyenv ]]; then 
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
fi 

# goenv
if [[ -d $HOME/.goenv ]]; then 
  export GOENV_ROOT=$HOME/.goenv
  export PATH=$GOENV_ROOT/bin:$PATH
  eval "$(goenv init -)"
fi

# sdkman
if [[ -d $HOME/.sdkman ]]; then 
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
  export JAVA_HOME=$HOME/.sdkman/candidates/java/current
  export PATH=$JAVA_HOME/bin:$PATH
fi 

# dotnet
if [[ -d $HOME/.dotnet/tools ]]; then
  export PATH=$HOME/.dotnet/tools:$PATH
fi

case ${OS} in 
  ubuntu)
    export ZPLUG_HOME=$HOME/.zplug
    ;;
  wsl_ubuntu)    
    ;;
  *)
    echo "not supported"
    ;;
esac