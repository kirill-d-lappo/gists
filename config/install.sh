#!/bin/bash

wd=$(dirname "$(realpath $0)")

cp -v "$wd/_tmux.conf" "$HOME/.tmux.conf"
cp -v "$wd/_vimrc"     "$HOME/.vimrc"

cp -r -v "$wd/_config" -t "$HOME/"

echo "Sourcing ~/.bashrc"
source ~/.bashrc
