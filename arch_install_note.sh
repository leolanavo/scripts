#!/bin/bash

# Setting up locale
nano /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

# Setting up NTP and Time
ls -s /usr/share/zoneinfo/Brazil/East > /etc/localtime
hwclock --systohc --utc

# Hostname setting
echo $2 > /etc/hostname

# Expanding MirroList
nano /etc/pacman.conf
pacman -Sy

# Packages
pacman -S xorg-server xorg-xinit xorg-twm xorg-xclock xterm xclip xorg-xrandr \
          wpa_supplicant dialog networkmanager openssh network-manager-applet \
          acpi intel-ucode libinput pulseaudio alsa-utils bluez bluez-utils \
          gnome gdm gnome-extra gnome-tweak-tool \
          file-roller neovim htop evince ranger termite compton \
          zsh feh maim sxiv mpd pavucontrol blueberry wget cmatrix atril \
          emacs gimp inkscape rofi vlc yaourt \
          texstudio texlive-core texlive-lang \
          python3 ruby nodejs npm jre9-openjdk-headless jre9-openjdk \
          jdk9-openjdk openjdk9-doc openjdk9-src racket \
          --noconfirm

systemctl enable NetworkManager.service
systemctl enable gdm.service

# Add user
useradd -m -g users -G wheel,storage,power -s /bin/zsh $1

# Add sudo power to new user
EDITOR=nano visudo

# Set up passwords
echo "Set up the root password"
passwd
echo "Set up your own password"
passwd $1

# Import keys for discord app
gpg --recv-key 0FC3042E345AD05D
gpg --lsign 0FC3042E345AD05D

# AUR packages
yaourt -S google-chrome spotify gnome-software \
          neovim-symlinks polybar-git i3-gaps \
          lightdm-webkit2-greeter gnome-software \
          sublime-text-dev neofetch light discord \
          lightdm-webkit2-theme-material2 --noconfirm

# Dotfiles installation
git clone http://github.com/leolanavo/dotfiles /home/lana/dotfiles
/home/lana/dotfiles/install all
