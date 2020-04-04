### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p $HOME/.zinit
    command git clone https://github.com/zdharma/zinit $HOME/.zinit/bin && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%F" || \
        print -P "%F{160}▓▒░ The clone has failed.%F"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# 補完
zinit load 'zsh-users/zsh-autosuggestions'
zinit load 'zsh-users/zsh-completions'
zinit load 'zsh-users/zsh-history-substring-search'

# 構文のハイライト
zinit load 'zsh-users/zsh-syntax-highlighting'

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
zstyle ':completion:*:default' menu select=2
# ビープを鳴らさない
setopt no_beep

# powerline-go
function powerline_precmd() {
    PS1="$(/usr/local/bin/powerline-go -error $? -shell zsh -modules venv,user,ssh,cwd,perms,git,hg,jobs,exit -newline)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi
