#!/bin/bash

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

install_rust() {	
	if [[ ! -d $HOME/.cargo ]]; then
	  curl https://sh.rustup.rs -sSf | sh
	fi
}


sudo apt-get -y update
sudo apt-get -y upgrade

declare -ar packages=(
  'zsh'
  'build-essential'
	'curl'
  # X転送
  'openssh-server'
  'x11-apps'
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

install_zplugin
install_rust

sudo apt-get -y autoremove

