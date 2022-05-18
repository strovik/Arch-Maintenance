#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Minsk /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=en_US-latin1" >> /etc/vconsole.conf
echo "curie" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 curie.localdomain curie" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S refind gdisk networkmanager network-manager-applet  wpa_supplicant mtools dosfstools base base-devel linux linux-headers linux-firmware bluez bluez-utils bash-completion openssh rsync reflector

# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

refind-install

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable reflector.timer


useradd -m mac
echo mac:password | chpasswd
usermod -aG wheel,audio,video,storage mac

echo "mac ALL=(ALL) ALL" >> /etc/sudoers.d/mac


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




