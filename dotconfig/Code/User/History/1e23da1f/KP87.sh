#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# sudo apt update && sudo apt upgrade -y

sudo mkdir ~/.config
chown $(whoami): ~/.config
sudo mv ./bg.jpg ~/.config

sudo apt install 