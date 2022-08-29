#!/bin/bash


if [ "$UID" -ne 0 ] 
then
    echo "Elevating execution rights"
    exec sudo bash "$0" "$@"
    exit
fi

sudo add-apt-repository ppa:neovim-ppa/unstable


sudo apt-get update && sudo apt-get upgrade -y


sudo apt-get install -y git tree build-essential neovim 


curl -sS https://starship.rs/install.sh | bash
