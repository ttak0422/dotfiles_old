declare -r os=($(bin/get_os))

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

if [[ -d $HOME.sdkman ]]; then 
  export SDKMAN_DIR="/home/tak/.sdkman"
  [[ -s "/home/tak/.sdkman/bin/sdkman-init.sh" ]] && source "/home/tak/.sdkman/bin/sdkman-init.sh"
  export JAVA_HOME=$HOME/.sdkman/candidates/java/current
  export PATH=$JAVA_HOME/bin:$PATH
fi 

case ${os} in 
  ubuntu)
    export ZPLUG_HOME=$HOME/.zplug
    ;;
  wsl_ubuntu)    
    ;;
  *)
    echo "not supported"
    ;;
esac