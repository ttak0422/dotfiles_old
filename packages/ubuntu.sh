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
    sudo service docker start
  fi
}

install_compose() {
  if [[ ! -e /usr/local/bin/docker-compose ]]; then 
    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
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

install_tpm() {
  if [[ ! -e $HOME/.tmux/plugins/tpm ]]; then 
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
  'openssh-server'
  # clion #
  'cmake'
  'gdb'
  #########
)

for p in ${packages[@]}; do 
  sudo apt-get install -y ${p}
done 

source ../zsh/.zshenv

install_zinit
install_powerline
install_python
install_jvm
install_tpm
# install_docker
# install_compose

sudo apt-get -y autoremove
source ../zsh/.zshenv