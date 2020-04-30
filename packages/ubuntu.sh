#!/bin/bash -eu

declare -r SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd $SCRIPT_DIR

install_nix() {
  if [[ ! -e $HOME/.nix-profile ]]; then
    curl https://nixos.org/nix/install | sh;
    $HOME/.nix-profile/etc/profile.d/nix.sh;  
    # add unstable channels
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable;
    nix-channel --update;
  fi
}

install_cachix() {
  nix-env -q 'cachix.*' > /dev/null
  if [ $? -ne 0 ]; then
    nix-env -iA nixpkgs.cachix;
  fi
}

install_homemanager() {
  nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install
}

install_nix
install_cachix
install_homemanager