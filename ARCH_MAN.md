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
5. Remap keys (https://www.reddit.com/r/vim/comments/j4e7b8/remapping_capslock_to_esc_when_tapped_and_ctrl/)

Packages (nvim):
- `nvim`
- `zathura`             (pdf viewer)
- `fzf`                 (fuzzy finder)
- `ripgrep`             (better grep)
- `lua-language-server` (lua lsp)
- `clang`               (c lsp)
- `make`                (make)
- `tinymist`            (typst lsp)

Packages (hyprland):
- `hyprland`,`alacritty`,`firefox`
- `swww`                (wallpaper daemon)
- `waybar`              (status bar)
- `thunar`              (file viewer)
- `alsa-utils`          (sounds)
- `brightnessctl`       (brightness)
- `rofi-wayland`        (app launcher)
- `wlogout`             (logout)
- `slurp`               (region selector)
- `grim`                (image grabber)

Packages (general):
- `chromium`            (browser)
- `whatsapp-for-linux`  (messaging)
- `discord`             (messaging)
- `inkscape`            (svg editor)
- `obs-studio`          (recorder)
- `godot`               (game engine)
- `lazygit`             (git tui)
- `nodejs`              (node)
- `gcc`                 (libc)
- `neofetch`            (fetch)
- `dunst`               (notification daemon)
- `wl-clipboard`        (system clipboard)
- `vlc`                 (media player)
- `qview`               (image viewer)
- `zip`,`unzip`,`7zip`  (archives)
- `eza`                 (better `ls`)
- `zoxide`              (better `cd`)
- `bat`                 (better `cat`)
- `bottom`              (better `top`)
- `sage`                (calculator)
- `imagemagick`         (image converter)
- `bind`                (network stuff)
- `nmap`,`socat`        (network listening)
- `file`                (file inspector)
- `which`               (binary locator)
- `tree`                (file tree visualizer)
- `wget`                (HTTP requester)
- `glow`                (markdown viewer)
- `pulseaudio`          (audio)
- `pipewire`            (audio)
- `strace`,`ltrace`     (call monitoring)
- `typst`               (typst)
- `zsh`                 (shell)
- `tmux`                (terminal multiplexer)
- `starship`            (terminal prompt)
- `nix`                 (nix)
- `bluez`,`bluez-utils` (bluetooth)

Packages (fonts):
- `font-awesome`
- `powerline-fonts`
- `powerline-symbols`
- `nerd-fonts.mononoki`
- `nerd-fonts.symbols-only`

Packages (extra):
- `openvpn`             (vpn)
- `jellyfin-ffmped`     (file converter/video player)
- `obsidian`            (notes)
- `ghc`                 (haskell)

