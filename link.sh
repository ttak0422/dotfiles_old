#!/bin/bash

set -u
DOT_DIRECTORY="${HOME}/dotfiles"

echo "start : link dotfiles"

cd ${DOT_DIRECTORY}

for f in .??*
do
    [ "$f" = ".git" ] && continue
    [[ -e $HOME/$f ]] && continue
    ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

echo "completed!"
