#!/bin/bash

#Network Packages
pacman -S wpa_supplicant dialog networkmanager openssh networkmanager-applet
systemctl enable NetworkManager.service

#Xorg Packages
pacman -S xorg-xinput xf86-input-synaptics

#Video Driver and GUI Packages
pacman -S nvidia mesa-libgl gnome gdm gnome-extra gnome-tweak-tool
systemctl enable gdm.service

#Boot Manager Packages
pacman -S refind-efi efibootmgr 
mkrlconf
nano /boot/refind_

#Apps Packages
pacman -S file-roller vim tmux htop sublime-text texstudio atril jre7-openjdk pacman -S jre7-openjdk python3

#AUR Packages
yaourt -S google-chrome spotify gnome-software

#Vundle and Powerline installations
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/powerline/fonts.git
./fonts/install.sh
