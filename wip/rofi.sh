#!/usr/bin/env bash

rPath=/tmp/rofi

if [[ ! -e $rPath ]]; then
  git clone https://github.com/adi1090x/rofi.git $rPath
fi

if [[ ! -e $HOME/.config/rofi ]]; then
  mkdir -p $HOME/.config
fi

xs=(android bin fonts launchers power scripts themes config.rasi)
for x in ${xs[@]}; do 
  cp -rf $rPath/$x $HOME/.config/rofi/
done