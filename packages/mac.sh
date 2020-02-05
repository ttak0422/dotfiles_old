#!/bin/bash

declare -r SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd $SCRIPT_DIR

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
)

declare -ar brew_packages=(
)

for p in ${brew_cask_packages[@]}; do
    brew cask install $p
done

for p in ${brew_packages[@]}; do 
    brew install $p 
done