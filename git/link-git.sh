#!/bin/bash

readonly SCRIPT_DIR=$(cd $(dirname $0) && pwd)

echo $SCRIPT_DIR
cd $SCRIPT_DIR

for file in .??*; do 
  echo $file
  [ -e ${HOME}/${file} ] && continue
  ln -snfv ${SCRIPT_DIR}/${file} ${HOME}/${file}
done