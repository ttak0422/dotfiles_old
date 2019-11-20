#!/bin/bash -eu

package_list=()

declare -a os_info=($(bin/get_os_info))

case ${os_info[0]} in 
  ubuntu)
    package_list=(
        "curl"
        "vim"
        "zsh"
        "build-essential"
        "apt-transport-https"
        "ca-certificates"
        "software-properties-common"
        "zip"
        "libssl-dev"
        "libreadline-dev"
        "zlib1g-dev"
    )
    ;;
  *)
    echo "not supported"
    ;;
esac

for list in ${package_list[@]}; do
  sudo apt-get install -y ${list}
done

sudo apt-get update 
sudo apt-get upgrade 

case ${os_info[0]} in 
  ubuntu)
    # zplugin
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
    # Docker stable
    sudo apt-get update
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    # rbenv
    if [ ! -e "$HOME/.rbenv" ]; then
      git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
      echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zprofile
      echo 'eval "$(rbenv init -)"' >> ~/.zprofile
      git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
      source ~/.zprofile
    fi
    ## ruby
    source ~/.zprofile
    rbenv install 2.6.0
    rbenv global 2.6.0
    # .NET Core3.0
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo add-apt-repository universe
    sudo apt-get update
    sudo apt-get install -y apt-transport-https
    sudo apt-get update
    sudo apt-get install -y dotnet-sdk-3.0
    # mono
    sudo apt install -y mono-devel
    ## FAKE
    dotnet tool install fake-cli -g
    ## Paket
    dotnet tool install --global Paket
    # node (https://qiita.com/seibe/items/36cefcurl -s "https://get.sdkman.io" | bash7df85fe2cefa3ea)
    sudo apt install -y nodejs npm
    sudo npm install n -g
    sudo n stable
    sudo apt purge -y nodejs npm
    # yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install -y yarn
    # SDKMAN
    set +u
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    ## Java
    sdk install java
    echo 'export JAVA_HOME=$HOME/.sdkman/candidates/java/current' >> ~/.zprofile
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.zprofile
    ## groovy
    sdk install groovy
    ## kotlin 
    sdk install kotlin
    ## sbt 
    sdk install sbt
    ## scala
    sdk install scala
    set -u
    # elm
    curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
    gunzip elm.gz
    chmod +x elm
    sudo mv elm /usr/local/bin/
    # HAXE
    sudo add-apt-repository ppa:haxe/releases -y
    sudo apt-get update
    sudo apt-get install haxe -y
    mkdir ~/haxelib && haxelib setup ~/haxelib
    # Pythpackage_liston
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
    echo 'eval "$(pyenv init -)"' >> ~/.zprofile
    source ~/.zprofile
    pyenv install 3.8.0
    pyenv global 3.8.0
    ;;
  *)
    echo "not supported"
    ;;
esac

sudo apt autoremove