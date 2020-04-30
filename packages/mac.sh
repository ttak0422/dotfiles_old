#!/bin/bash -eu

declare -r SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd $SCRIPT_DIR


# WIP nix ########################################################

# READ
# https://github.com/NixOS/nix/issues/2925#issuecomment-604501661
# GUI アプリのインストールは避ける


# 1. Install nix
# 2. Add unstable channel
# 3. Add cacix.
# 4. Add home-manager (add channel && install)

#################################################################



# brew ##########################################################

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install bash
brew install cask
brew cask install google-chrome
brew cask install visual-studio-code
brew cask install iterm2
brew cask install docker
brew tap homebrew/cask-fonts
brew cask install font-hackgen