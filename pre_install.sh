#!/usr/bin/env bash
set -euo pipefail
# get the variables from the user
read USER
read -s PASSWORD
# set up time-date and repos
pacman -Syyy
timedatectl set-ntp true
# partioning and formating disks

#mkfs.fat -F32 /dev/sda1
#mkfs.ext4 /dev/sda2
#mount /dev/sda2 /mnt
#mkdir /mnt/boot
#mount /dev/sda1 /mnt/boot
# installing software
pacstrap /mnt base base-devel linux-zen 
pacstrap /mnt grub efibootmgr networkmanager 
pacstrap /mnt pulsemixer playerctl linux-firmware
pacstrap /mnt git dialog kitty intel-ucode stow 
pacstrap /mnt bluez bluez-utils dialog mpv-mpris
pacstrap /mnt zsh zsh-syntax-highlighting zsh-autosuggestions
pacstrap /mnt nvim pulseaudio firefox zathura nnn
pacstrap /mnt gvfs-afc gvfs-mtp ffmpegthumbnailer 
pacstrap /mnt lua mpv ttf-dejavu python python-pip
pacstrap /mnt powerline-fonts wl-clipboard youtube-dl
pacstrap /mnt zathura-djvu zathura-pdf-poppler mako 
# generating fs and chrooting
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash ./chroot_install.sh $USER $PASSWORD
# finishing installation
exit
umount -a
reboot
