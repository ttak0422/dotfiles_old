#!/usr/bin/env bash

declare -r SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd $SCRIPT_DIR

if [[ ! -e $HOME/.config ]]; then 
  mkdir -p "$HOME/.config"
fi 

ln -sf `readlink -f ./../nixpkgs` "$HOME/.config/nixpkgs"