#!/usr/bin/env bash
set -euo pipefail

# configuring locale settings
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i 's/^#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
# setting up username
echo $USER > /etc/hostname
echo "127.0.0.1    localhost
::1          localhost
127.0.1.1    $USER.localdomain $USER" > /etc/hosts
# installing grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
# setting up home user
useradd -mG wheel $USER
passwd $USER
echo $USER:$PASSWORD | chpasswd
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
# enabling services
systemctl enable NetworkManager
systemctl enable bluetoothd
