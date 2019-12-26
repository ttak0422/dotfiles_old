#!/bin/bash -e

declare -r SCRIPT_DIR=$(cd $(dirname $0) && pwd)

cd $SCRIPT_DIR

is_installed_package() {
  command -v "$1" > /dev/null;
}

install_zplugin() {
  if [[ ! -d $HOME/.zplugin ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
  fi
}

install_ruby() {
  source ~/.zshenv
  # rbenv
  if [[ ! -d $HOME/.rbenv ]]; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  fi
  # ruby
  if ! is_installed_package ruby ; then
    rbenv install -s 2.6.0
    rbenv global 2.6.0
  fi
}

install_python() {
  source ~/.zshenv
  # pyenv
  if [[ ! -d $HOME/.pyenv ]]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv    
  fi
  # python
  if ! is_installed_package python ; then
    pyenv install -s 3.8.0
    pyenv global 3.8.0
  fi
}

install_go() {
  source ~/.zshenv
  # goenv
  if [[ ! -d $HOME/.goenv ]]; then
    git clone https://github.com/syndbg/goenv.git ~/.goenv
  fi
  # go
  if ! is_installed_package go ; then
    goenv install 1.13.0
    goenv global 1.13.0
    goenv rehash
  fi
}

install_dotnet() {
  # .NET Core3.0
  if ! is_installed_package dotnet ; then 
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    sudo add-apt-repository universe
    sudo apt-get update
    sudo apt-get install -y apt-transport-https
    sudo apt-get update
    sudo apt-get install -y dotnet-sdk-3.0
  fi
  # mono
  if ! is_installed_package mono ; then 
    sudo apt install -y mono-devel
  fi
  # FAKE
  if ! is_installed_package fake ; then
    dotnet tool install fake-cli -g
  fi
  # Paket
  if ! is_installed_package paket ; then
    dotnet tool install --global Paket
  fi
}

install_jvm() {
  # SDKMAN
  if ! is_installed_package sdk ; then
    set +u
    curl -s "https://get.sdkman.io" | bash
    source $HOME/.sdkman/bin/sdkman-init.sh
    set -u
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

install_node() {
  # node
  if ! is_installed_package n ; then
    sudo apt install -y nodejs npm
    sudo npm install n -g
    sudo n stable
    sudo apt purge -y nodejs npm
  fi
  # yarn
  if ! is_installed_package yarn ; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install -y yarn
  fi
}

install_elm() {
  if ! is_installed_package elm ; then
    curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
    gunzip elm.gz
    chmod +x elm
    sudo mv elm /usr/local/bin/
  fi
}

install_haxe() {
  if ! is_installed_package haxe ; then
    sudo add-apt-repository ppa:haxe/releases -y
    sudo apt-get update
    sudo apt-get install haxe -y
    mkdir ~/haxelib && haxelib setup ~/haxelib
  fi
}

sudo apt-get -y update
sudo apt-get -y upgrade

declare -ar packages=(
  'zsh'
  'build-essential'
  # ruby
  'libssl-dev'
  'libreadline-dev'
  'zlib1g-dev'
  # SDKMAN
  'unzip'
  'zip'
)

for p in ${packages[@]}; do 
  sudo apt-get install -y ${p}
done 

source ~/.zshenv

install_zplugin
install_ruby
install_python
install_dotnet
install_jvm
install_node
install_elm
install_haxe
install_go

sudo apt-get -y autoremove

source ~/.zshenv