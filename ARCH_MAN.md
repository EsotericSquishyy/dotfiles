Install (https://www.youtube.com/watch?v=68z11VAYMS8):
1. Connect to internet
2. Partition/format/mount disk (`ext4 /mnt/`, `swap [SWAP`, `fat32 /mnt/boot/efi`
3. `pacstrap -K /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nvim git openssh networkmanager`
4. `genfstab -U /mnt >> /mnt/etc/fstab`
5. timezone, locale, keyboard layout, hostname
6. add user (add to `wheel` and enable the group)
7. `systemctl enable NetworkManager`
8. `grub-install /dev/[device]` and `grub-mkconfig -o /boot/grub/grub.cfg`

Post-Install:
1. `sudo pacmand -S hyprland alacritty firefox`
2. Setup ssh-key for github and clone dotfiles
3. `./install.sh`
