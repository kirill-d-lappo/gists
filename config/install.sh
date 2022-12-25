#!/bin/bash

wd=$(dirname "$(realpath $0)")

cp -v "$wd/.tmux.conf" -t ~/
cp -v "$wd/.vimrc"     -t ~/
cp -v "$wd/.inputrc"   -t ~/

cp -r -v "$wd/.config" -t ~/


# append .bashrc instead of rewriting the whole file
echo "Appending user setups to .bashrc"
cat "$wd/.bashrc-append" >> ~/.bashrc

echo "Sourcing ~/.bashrc"
source ~/.bashrc
