#!/usr/bin/env bash
set -euo pipefail

# get the variables from the user
read ROOT
passwd
read USER
read -s PASSWORD
# configuring locale settings
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i 's/^#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
# setting up username
echo $ROOT > /etc/hostname
echo "127.0.0.1    localhost
::1          localhost
127.0.1.1    $ROOT.localdomain $ROOT" > /etc/hosts
# installing grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
# setting up home user
useradd -mG wheel $USER
echo $USER:$PASSWORD | chpasswd
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
# enabling services
systemctl enable NetworkManager
systemctl enable bluetooth
# finishing installation
exit
umount -a
reboot
