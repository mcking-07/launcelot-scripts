#!/bin/bash

#check if root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

#update system
sudo apt update && sudo apt upgrade -y

#remove snapd services
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service

# remove snap packages
sudo snap list | awk '{print $1}' | xargs sudo snap remove

#remove snapd files and folders
sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd
sudo rm -rf ~/snap

#system update
sudo apt update && sudo apt upgrade -y

#install media codecs
sudo apt install ubuntu-restricted-extras -y

# insatll applications
sudo apt install wget git curl neofetch cmatrix figlet nano vim neovim -y

# install dev-tools
sudo apt install apt-transport-https build-essential gcc g++ cmake nodejs npm software-properties-common python3 -y

# download commonly used deb packages
mkdir -p deb-packages/ && cd deb-packages/
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome.deb
wget https://updates.getmailspring.com/download?platform=linuxDeb -O mailspring.deb
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.20.0-amd64.deb -O slack.deb
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 -O code.deb

# install deb packages
sudo dpkg -i google-chrome.deb mailspring.deb slack.deb code.deb -y

# remove deb files after install
rm -rf ./google-chrome.deb ./mailspring.deb ./slack.deb ./code.deb

# install gnome-tools
sudo apt install chrome-gnome-shell -y
sudo apt install gnome-tweaks gnome-shell-extension-manager chrome-gnome-shell -y
sudo apt install --install-suggests gnome-software -y && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install gnome-extensions
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable Hide_Activities@shay.shayel.org
gnome-extensions enable openweather-extension@jenslody.de
gnome-extensions enable search-light@icedman.github.com
gnome-extensions enable rocketbar@chepkun.github.com
gnome-extensions enable openweather-extension@jenslody.d
gnome-extensions enable clipboard-history@alexsaveau.dev
gnome-extensions enable burn-my-windows@schneegans.github.com

# download nord theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git Nordify

# install nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh

# install fonts
cd ~/
sudo apt install fonts-font-awesome
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /usr/share/fonts

# remove files and folders and reload cache
rm -rf FiraCode.zip Meslo.zip Nordzy-cursors 
fc-cache -vf
