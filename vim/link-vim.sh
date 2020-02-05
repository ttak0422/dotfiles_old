#!/bin/bash

readonly SCRIPT_DIR=$(cd $(dirname $0) && pwd)

cd $SCRIPT_DIR

for file in .??*; do 
  [ -e ${HOME}/${file} ] && continue
  ln -snfv ${SCRIPT_DIR}/${file} ${HOME}/${file}
done