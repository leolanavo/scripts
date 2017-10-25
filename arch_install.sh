#!/bin/bash

# Boot manager packages
pacman -S refind-efi os-prober
refind-install --usedefault $1
mkrlconf
nano /boot/refind_linux.conf

# Setting up locale
nano /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

# Setting up NTP and Time
ls -s /usr/share/zoneinfo/Brazil/East > /etc/localtime
hwclock --systohc --utc
pacman -S ntp --noconfirm
timedatectl set-ntp true
timedatectl set-timezone America/Sao_Paulo
systemctl enable ntpd.service

# Hostname setting
echo $3 > /etc/hostname

# Expanding MirroList
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
pacman -Sy

# Add user
useradd -m -g users -G wheel,storage,power -s /bin/bash $2

# Add sudo power to new user
echo "%wheel ALL=(ALL) ALL"

# Set up passwords
echo "Set up the root password"
passwd
echo "Set up your own password"
passwd $2

# Xorg packages
pacman -S xorg-server xorg-server-utils xorg-xinit \
          xorg-twm xorg-xclock xterm xclip xorg-xrandr

# Network packages
pacman -S wpa_supplicant dialog networkmanager openssh networkmanager-applet
systemctl enable NetworkManager.service

# Driver packages
pacman -S nvidia mesa mesa-libgl lib32-mesa-libgl \
          acpi intel-ucode libinput pulseaudio alsa-utils \
          bluez bluez-utils --noconfirm

# GNOME packages
pacman -S gnome gdm gnome-extra gnome-tweak-tool --noconfirm

# LightDM packages
pacman -S lightdm --noconfirm
systemctl enable lightdm.service

# Apps packages
pacman -S file-roller neovim tmux htop texstudio evince ranger \
          termite compton zsh feh maim sxiv mpd pavucontrol \
          blueberry wget cmatrix atril emacs gimp inkscape \
          rofi vlc yaourt --noconfirm

# Tex packages
pacman -S texlive-core texlive-lang --noconfirm

# Language packages
pacman -S python3 ruby jre9-openjdk-headless jre9-openjdk \
          jdk9-openjdk openjdk9-doc openjdk9-src nodejs npm \
          racket --noconfirm

# AUR packages
yaourt -S google-chrome spotify-client gnome-software \
          neovim-symlinks polybar-git i3-gaps-git \
          lightdm-webkit2-greeter gnome-software \
          sublime-text-dev neofetch light discord \
          lightdm-webkit2-theme-material2 --noconfirm

# Dotfiles installation
git clone http://github.com/leolanavo/dotfiles /home/lana/dotfiles
cd /home/lana/dotfiles
./install all
