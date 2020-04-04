#!/bin/bash -e

declare -r SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd $SCRIPT_DIR

is_installed_package() {
  command -v "$1" > /dev/null;
}

install_zinit() {
  if [[ ! -d $HOME/.zinit ]]; then 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)" && 
    wait
  fi
}

install_python() {
  # pyenv
  if [[ ! -d $HOME/.pyenv ]]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv    
  fi
  source ~/.zshenv
  # python
  if ! is_installed_package python ; then
    pyenv install -s 3.8.0
    pyenv global 3.8.0
  fi
}

install_jvm() {
  # SDKMAN
  if ! is_installed_package sdk ; then
    curl -s "https://get.sdkman.io" | bash
    source $HOME/.sdkman/bin/sdkman-init.sh
  fi
  # Java
  if ! is_installed_package java ; then
    sdk install java   
  fi
  # groovy
  if ! is_installed_package groovy ; then
    sdk install groovy
  fi
  # kotlin 
  if ! is_installed_package kotlin ; then
    sdk install kotlin
  fi
  # sbt 
  if ! is_installed_package sbt ; then 
    sdk install sbt
  fi
  # scala
  if ! is_installed_package scala ; then
    sdk install scala
  fi
}

install_powerline() {
  if [[ ! -e /usr/local/bin/powerline-go ]]; then
    curl -s https://api.github.com/repos/justjanne/powerline-go/releases/latest \
    | grep -E 'browser_download_url.*linux.*' \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | sudo wget -O /usr/local/bin/powerline-go -qi -
    sudo chmod +x /usr/local/bin/powerline-go
  fi
}

sudo apt-get -y update
sudo apt-get -y upgrade

declare -ar packages=(
  'zsh'
  'build-essential'
  'curl'
  'unzip'
  'zip'
  'uidmap'
  'tmux'
  'libssl-dev'
  'libbz2-dev'
  'libreadline-dev'
  'libsqlite3-dev'
  'zlib1g-dev'
  'tree'
  'tig'
)

for p in ${packages[@]}; do 
  sudo apt-get install -y ${p}
done 

source ../zsh/.zshenv

install_zinit
install_powerline
install_python
install_jvm

sudo apt-get -y autoremove
source ../zsh/.zshenv
