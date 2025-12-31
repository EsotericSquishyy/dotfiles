#! /usr/bin/env bash

# ----- Yay install -----
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
fi


# ----- Package manager update -----
read -n1 -rep 'Would you like to update packages? (y,n)' UPDT
if [[ $UPDT == "Y" || $UPDT == "y" ]]; then
    sudo pacman -Syu --noconfirm # -Syy to force refresh
    yay -Syu --noconfirm
fi


# ----- Install all of the above pacakges -----
read -n1 -rep 'Would you like to install the packages? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    # ALPM packages
    packages=(
        # # Installed pre-install
        # base
        # linux
        # linux-firmware
        # sof-firmware
        # base-devel
        # grub
        # efibootmgr
        # nvim
        # git
        # openssh
        # networkmanager

        # Fundamentals
        firefox                         # browser (https://github.com/adriankarlen/textfox#)
        hyprland                        # Wayland compositor
        hyprlock                        # Lock screen
        alacritty                       # terminal emulator

        # Neovim
        zathura                         # PDF viewer
        zathura-djvu                    # djvu zathura support
        zathura-pdf-mupdf               # pdg zathura support
        fzf                             # fuzzy finder
        ripgrep                         # better grep
        clang                           # c lsp
        llvm                            # llvm
        make                            # make
        yarn                            # js package manager

        # Hyprland
        greetd                          # greeter daemon
        greetd-tuigreet                 # greeter
        xdg-desktop-portal-hyprland     # portal for Hyprland
        polkit                          # access control
        qt5-wayland                     # qt
        qt6-wayland                     # qt
        xdg-utils                       # extra utils
        swww                            # wallpaper daemon
        waybar                          # status bar
        alsa-utils                      # sound
        brightnessctl                   # brightness
        rofi-wayland                    # app launcher
        slurp                           # screen geometry
        grim                            # image grabber

        # Yazi
        yazi                            # file manager
        jellyfin-ffmpeg                 # media converter
        jq                              # json
        imagemagick                     # image converter
        ueberzugpp                      # image preview on alacritty

        # System utils
        pipewire                        # audio
        pipewire-audio                  # audio
        pipewire-pulse                  # audio
        pipewire-alsa                   # audio
        wireplumber                     # audio
        wl-clipboard                    # clipboard
        bind                            # network stuff
        bluez                           # bluetooth
        bluez-utils                     # bluetooth

        # Terminal Utils
        lazygit                         # git tui
        zip                             # archive tool
        unzip                           # archive tool
        7zip                            # archive tool
        eza                             # better ls
        zoxide                          # better cd
        bat                             # better cat
        bottom                          # better top
        nmap                            # network listener
        socat                           # network listener
        file                            # file inspection
        which                           # binary locator
        tree                            # file tree
        wget                            # HTTP requests
        tmux                            # terminal multiplexer
        fastfetch                       # fetch
        man-pages                       # man
        man-db                          # man
        less                            # pager
        chezmoi                         # symlinks

        # General
        chromium                        # browser
        discord                         # messaging
        inkscape                        # PDF editor
        obs-studio                      # recorder
        godot                           # game engine
        dunst                           # notification daemon
        vlc                             # video player
        zsh-syntax-highlighting         # syntax highlighting for zsh
        zsh-autocomplete                # autocomplete for zsh
        starship                        # prompt manager
        openvpn                         # vpn
        obsidian                        # notes
        keyd                            # key remapping
        ollama                          # LLMs
        python-pywal                    # pywal colorschemes

        # Langs
        nix                             # nix (`extra-experimental-features = nix-command flakes` to /etc/nix/nix.conf)
        zsh                             # shell
        nodejs                          # javascript
        npm                             # js package manager
        gcc                             # libc
        ghc                             # haskell
        python                          # python
        python-pip                      # python package manager
        python-uv                       # python package manager
        sagemath                        # calculator
        typst                           # typsetting language

        # Security
        qbittorrent-nox                 # Bit torrent
        termshark                       # Wireshark
        gef                             # gdb fork
        ghidra                          # rev
        radare2                         # rev
        strace                          # stack trace
        ltrace                          # stack trace

        # Docker
        docker                          # docker
        docker-buildx                   # docker buildx
        docker-compose                  # docker compose

        # Fonts
        # ttf-font-awesome
        # powerline-fonts
        nerd-fonts
        # noto-fonts
        noto-fonts-cjk
    )
    echo "${packages[@]}"
    sudo pacman -S --needed --noconfirm "${packages[@]}"

    # AUR packages
    aur_packages=(
        python-pywalfox                 # autocolor firefox
        vesktop-bin                     # messaging (https://github.com/refact0r/system24)
        # whatsapp-for-linux              # messaging
        qview                           # image viewer
        lean4-bin                       # lean
        wlogout                         # logout manager
        opencode-bin                    # opencode
        ttf-noto-emoji-monochrome       # emojis
    )
    yay -S --needed --noconfirm "${aur_packages[@]}"
fi


# ----- Nix Startup -----
read -n1 -rep 'Would you like to setup nix? (y,n)' NXSU
if [[ $NXSU == "Y" || $NXSU == "y" ]]; then
    sudo systemctl enable --now nix-daemon.service
    sudo groupadd nix-users
    sudo usermod -aG nix-users squishyy
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable
    nix-channel --update
fi


# ----- Chezmoi -----
read -n1 -rep 'Would you like to update chezmoi? (y,n)' CZMI
if [[ $CZMI == "Y" || $CZMI == "y" ]]; then
fi


# ----- Copy Config Files -----
read -n1 -rep 'Would you like to copy config files? (y,n)' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "Copying config files...\n"
    sudo stow --dotfiles -t "$HOME" bin hypr nvim tmux waybar zsh alacritty starship wlogout vesktop yazi fastfetch rofi
    sudo stow --dotfiles -t "/" greetd keyd

    if command -v firefox >/dev/null 2>&1; then
        mkdir -p "$HOME/.mozilla/firefox/squishyy-profile/"
        sudo stow --dotfiles -t "$HOME" firefox
    fi
fi



# ----- Pywal -----
read -n1 -rep 'Would you like to update pywal cache? (y,n)' PYW
if [[ $PYW == "Y" || $PYW == "y" ]]; then
    echo -e "Updating pywal cache...\n"
    wal -R # use -a 0 flag to disable background

    # Firefox
    pywalfox update

    # Waybar
    ln -s $HOME/.cache/wal/colors-waybar.css $HOME/.config/waybar/colors.css

    # Hyprland and Hyprlock
    ln -s $HOME/.cache/wal/colors-hyprland.conf $HOME/.config/hypr/colors.conf

    # Wlogout
    ln -s $HOME/.cache/wal/colors-wlogout.css $HOME/.config/wlogout/colors.css
    mkdir -p "$(readlink -f "$HOME/.config/wlogout")/icons"
    actions=("power" "reboot" "sleep" "logout")
    for action in "${actions[@]}"; do
        for type in bg fg; do
            src="$HOME/.cache/wal/${action}-${type}-wlogout.svg"
            dest="$HOME/.config/wlogout/icons/${action}-${type}.svg"
            ln -s "$src" "$dest"
        done
    done

    # Yazi
    ln -s $HOME/.cache/wal/theme-yazi.toml $HOME/.config/yazi/theme.toml

    # Vencord
    ln -s $HOME/.cache/wal/pywalcolors-vencord.theme.css $HOME/.config/vesktop/themes/pywalcolors.theme.css

    # Rofi
    ln -s $HOME/.cache/wal/colors-rofi.rasi $HOME/.config/rofi/colors.rasi
fi



# ----- Services -----
read -n1 -rep 'Would you like to start your services? (y,n)' SRVC
if [[ $SRVC == "Y" || $SRVC == "y" ]]; then
    # docker
    sudo systemctl enable --now docker

    # zsh
    if [[ "$SHELL" != "/bin/zsh" ]]; then
        echo -e "Changing default shell to zsh...\n"
        chsh -s /bin/zsh
    else
        echo -e "Default shell is already zsh. Skipping chsh...\n"
    fi

    # tmux
    echo -e "Tmux setup...\n"
    mkdir -p "$HOME/.tmux/plugins"
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi

    # Sound
    echo -e "Starting the Sound Services...\n"
    systemctl --user enable --now pipewire pipewire-pulse wireplumber
    sleep 2

    # Bluetooth
    echo -e "Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2

    # xdg
    echo -e "Cleaning out conflicting xdg portals...\n"
    sudo pacman -Rns --noconfirm --quiet xdg-desktop-portal-gnome xdg-desktop-portal-gtk 2>/dev/null
    xdg-settings set default-web-browser firefox.desktop

    # greetd
    echo -e "Enabling greeter...\n"
    sudo systemctl enable greetd
    sleep 2
    if ! getent passwd greeter > /dev/null; then
        sudo useradd -m -G video greeter
        sudo passwd -d greeter
    fi

    # keyd
    echo -e "Enabling keyd...\n"
    sudo systemctl enable --now keyd
    sleep 2

    # Desktop
    echo -e "Updating desktop database...\n"
    update-desktop-database "$HOME/.local/share/applications/"
    sleep 2
fi


echo -e "Script had completed!!!\n"
# ----- Resources -----
# For temporary installs: https://www.reddit.com/r/archlinux/comments/27yq8u/comment/ci5p3zt
# Discord update fix: https://www.reddit.com/r/linuxmasterrace/comments/10bq9qq/comment/j4bk0li
