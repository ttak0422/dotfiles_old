#!/bin/bash

declare -r SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd $SCRIPT_DIR

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

install_zinit

brew update

declare -ar brew_cask_packages=(
    'visual-studio-code'
    'jetbrains-toolbox'
    'dotnet-sdk'
    'iterm2'
    'karabiner-elements'
)

declare -ar brew_packages=(
    'rustup'
    'bat'
    'mono'
)

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

# check rustup-init
if is_installed_brew_package 'rustup' ; then
    if [[ ! -d $HOME/.cargo ]]; then 
        rustup-init
    fi
fi