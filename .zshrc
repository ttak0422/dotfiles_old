### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

# 補完
zplugin load 'zsh-users/zsh-autosuggestions'
zplugin load 'zsh-users/zsh-completions'
zplugin load 'zsh-users/zsh-history-substring-search'

# Load the pure theme, with zsh-async library that's bundled with it.
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

# 構文のハイライト
zplugin load 'zsh-users/zsh-syntax-highlighting'

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
zstyle ':completion:*:default' menu select=2

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

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
  export JAVA_HOME=$HOME/.sdkman/candidates/java/current
  export PATH=$JAVA_HOME/bin:$PATH
fi 

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock