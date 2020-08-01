#!/bin/bash

readonly SCRIPT_DIR=$(cd $(dirname $0) && pwd)

cd $SCRIPT_DIR

if [[ ! -e $HOME/.config ]]; then
  mkdir $HOME/.config 
fi

# home-manager
if [[ ! -e $HOME/.config/nixpkgs ]]; then
  ln -snfv $SCRIPT_DIR/nixpkgs $HOME/.config/nixpkgs
fi
