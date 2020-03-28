#!/bin/bash

readonly SCRIPT_DIR=$(cd $(dirname $0) && pwd)

cd $SCRIPT_DIR

for file in .??*; do
  if [[ ! -e $HOME/$file && -f $file ]]; then 
    ln -snfv ${SCRIPT_DIR}/${file} ${HOME}/${file}
  fi
done