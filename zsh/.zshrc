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
### End of Zinit installer's chunk

# 補完
zinit load 'zsh-users/zsh-autosuggestions'
zinit load 'zsh-users/zsh-completions'
zinit load 'zsh-users/zsh-history-substring-search'

# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

# 構文のハイライト
zinit load 'zsh-users/zsh-syntax-highlighting'

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
zstyle ':completion:*:default' menu select=2

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi
### End of Zinit's installer chunk
