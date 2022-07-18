#!/bin/bash

#check if root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

#update system
sudo apt update && sudo apt upgrade -y

#create .config, move config files
sudo mkdir ~/.config
chown $(whoami): ~/.config
# sudo mv ./bg.jpg ~/.config
sudo mv ./dotconfig/* ~/.config

#remove snapd services
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service

#remove snap packages
sudo snap remove firefox
sudo snap remove snap-store
sudo snap remove gtk-common-themes
sudo snap remove gnome-3-38-2004
sudo snap remove snapd-desktop-integration
sudo snap remove core20

#remove snapd files and folders
sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd
sudo rm -rf ~/snap

#system update
sudo apt update && sudo apt upgrade -y 

#install media codecs
sudo apt install ubuntu-restricted-extras -y

#insatll applications
sudo apt install wget git neofetch cmatrix figlet nano vim neovim -y 

#install deb packages
cd deb-packages/
sudo dpkg -i google-chrome.deb vscode.deb tabby.deb slack.deb mailspring.deb 