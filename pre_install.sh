#!/usr/bin/env bash
set -euo pipefail
# set up time-date and repos
pacman -Syyy
timedatectl set-ntp true
# installing software
pacstrap /mnt base base-devel linux linux-headers
pacstrap /mnt grub efibootmgr networkmanager 
pacstrap /mnt pulsemixer playerctl linux-firmware
pacstrap /mnt git alacritty intel-ucode stow
pacstrap /mnt bluez bluez-utils dialog
pacstrap /mnt zsh zsh-syntax-highlighting
pacstrap /mnt pulseaudio firefox zsh-autosuggestions
pacstrap /mnt gvfs-afc gvfs-mtp ffmpegthumbnailer 
pacstrap /mnt mpv ttf-dejavu youtube-dl picom
pacstrap /mnt powerline-fonts bspwm sxhkd mpv
pacstrap /mnt zathura-djvu zathura-pdf-poppler
pacstrap /mnt emacs cowfortune lolcat
# generating fs and chrooting
genfstab -U /mnt >> /mnt/etc/fstab
