#!/bin/bash -eu

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

install_rootless_docker() {
  if ! is_installed_package docker ; then 
    curl -fsSL https://get.docker.com/rootless | sh && wait
    systemctl --user start docker
  fi
}

install_compose() {
  if [[ ! -d /usr/local/bin/docker-compose ]]; then 
    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
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
)

for p in ${packages[@]}; do 
  sudo apt-get install -y ${p}
done 

source ../zsh/.zshenv

install_zinit
install_rootless_docker
install_compose

sudo apt-get -y autoremove
source ../zsh/.zshenv