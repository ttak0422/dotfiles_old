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