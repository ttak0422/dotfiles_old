#!/bin/bash

declare -r SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd $SCRIPT_DIR

# TODO: 
echo "Error: Move to nix";
exit 1;

declare OS=($(./../bin/get_os));

if [[ $OS != 'mac' ]]; then 
    echo "not supported";
    exit 1;
fi

is_installed_brew_package() {
    brew list | grep $1 > /dev/null
}

is_installed_brew_cask_package() {
    brew cask list | grep $1 > /dev/null
}

install_zinit() {
    if [[ ! -d $HOME/.zinit ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
    fi
}

install_powerline() {
  if [[ ! -e /usr/local/bin/powerline-go ]]; then
    curl -s https://api.github.com/repos/justjanne/powerline-go/releases/latest \
    | grep -E 'browser_download_url.*darwin.*' \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | sudo wget -O /usr/local/bin/powerline-go -qi -
    sudo chmod +x /usr/local/bin/powerline-go
  fi
}

install_tpm() {
  if [[ ! -e $HOME/.tmux/plugins/tpm ]]; then 
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

declare -ar brew_tap_repositories=(
    'homebrew/cask-fonts'
)

declare -ar brew_cask_packages=(
    'visual-studio-code'
    'jetbrains-toolbox'
    'dotnet-sdk'
    'iterm2'
    'karabiner-elements'
    'java'
    'font-hackgen'
)

declare -ar brew_packages=(
    'bat'
    'wget'
    'tmux'
    'tig'
    'screenfetch'
    'rustup'
    'mono'
    'yarn'
)

for r in ${brew_tap_repositories[@]}; do 
    brew tap $r;
done

for p in ${brew_cask_packages[@]}; do
    if ! is_installed_brew_cask_package $p ; then
        brew cask install $p
    fi
done

for p in ${brew_packages[@]}; do 
    if ! is_installed_brew_package $p ; then
        brew install $p 
    fi
done

install_zinit
install_powerline
install_tpm

brew update

# check rustup-init
# if is_installed_brew_package 'rustup' ; then
#     if [[ ! -d $HOME/.cargo ]]; then 
#         rustup-init
#     fi
# fi
