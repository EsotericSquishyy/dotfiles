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
3. Install all necessary packages (see below) using dotfiles
4. Update config files using dotfiles

Packages (nvim):
- `nvim`
- `zathura`             (pdf viewer)
- `fzf`                 (fuzzy finder)
- `ripgrep`             (better grep)
- `lua-language-server` (lua lsp)
- `clang`               (c lsp)
- `gnumake`             (make)
- `tinymist`            (typst lsp)

Packages (hyprland):
- `hyprland`, `alacritty`, `firefox`
- `swww`                (wallpaper daemon)
- `waybar`              (status bar)
- `xfce.thunar`         (file viewer)
- `also-utils`          (sounds)
- `brightnessctl`       (brightness)
- `rofi-wayland`        (app launcher)
- `wlogout`             (logout)
- `slup`                (region selector)
- `grim`                (image grabber)

Packages (general):
- `ungoogled-chromium`  (browser)
- `whatsapp-for-linux`  (messaging)
- `discord`             (messaging)
- `inkscape`            (svg editor)
- `obs-studio`          (recorder)
- `godot_4`             (game engine)
- `lazygit`             (git tui)
- `nodejs_24`           (node)
- `libgcc`              (libc)
- `neofetch`            (fetch)
- `dunst`               (notification daemon)
- `wl-clipboard`        (system clipboard)
- `vlc`                 (media player)
- `qview`               (image viewer)
- `zip`, `unzip`, `7z`  (archives)
- `eza`                 (better `ls`)
- `zoxide`              (better `cd`)
- `bat`                 (better `cat`)
- `bottom`              (better `top`)
- `sage`                (calculator)
- `imagemagick`         (image converter)
- `dig`                 (network digging)
- `nmap`, `socat`       (network listening)
- `file`                (file inspector)
- `which`               (binary locator)
- `tree`                (file tree visualizer)
- `wget`                (HTTP requester)
- `glow`                (markdown viewer)
- `pulseaudio`          (audio)
- `strace`, `ltrace`    (call monitoring)
- `typst`               (typst)
- `zsh`                 (shell)

Packages (fonts):
- `font-awesome`
- `powerline-fonts`
- `powerline-symbols`
- `nerd-fonts.mononoki`
- `nerd-fonts.symbols-only`

Packages (extra):
- `openvpn`             (vpn)
- `jellyfin-ffmped`     (file converter/video player)
- `usbimager`           (iso imager)
- `obsidian`            (notes)
- `ghc`                 (haskell)
- `lean4`               (lean)

