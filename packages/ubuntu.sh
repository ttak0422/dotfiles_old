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

install_docker() {
  if [[ ! -e /usr/bin/docker ]]; then
    sudo apt-get -y install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
    sudo apt-get -y update
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
    sudo service docker --full-restart
  fi
}

install_compose() {
  if [[ ! -e /usr/local/bin/docker-compose ]]; then 
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
  'tmux'
)

for p in ${packages[@]}; do 
  sudo apt-get install -y ${p}
done 

source ../zsh/.zshenv

install_zinit
install_docker
install_compose

sudo apt-get -y autoremove
source ../zsh/.zshenv