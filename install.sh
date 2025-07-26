#! /usr/bin/env bash

# For temporary installs: https://www.reddit.com/r/archlinux/comments/27yq8u/comment/ci5p3zt
# Discord update fix: https://www.reddit.com/r/linuxmasterrace/comments/10bq9qq/comment/j4bk0li

# ----- Yay install -----
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
fi

# ----- Disable wifi powersave mode -----
read -n1 -rep 'Would you like to disable wifi powersave? (y,n)' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "The following has been added to $LOC.\n"
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Restarting NetworkManager service...\n"
    sudo systemctl restart NetworkManager
    sleep 3
fi


# ----- Package manager update -----
read -n1 -rep 'Would you like to update packages? (y,n)' UPDT
if [[ $UPDT == "Y" || $UPDT == "y" ]]; then
    sudo pacman -Syu --noconfirm
    yay -Syu --noconfirm
fi


# ----- Install all of the above pacakges -----
read -n1 -rep 'Would you like to install the packages? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then

    # Pacman packages
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
        firefox                         # browser
        hyprland                        # Wayland compositor
        hyprlock                        # Lock screen
        alacritty                       # terminal emulator

        # Neovim
        zathura                         # PDF viewer
        zathura-djvu                    # djvu zathura support
        zathura-pdf-mupdf               # pdg zathura support
        fzf                             # fuzzy finder
        ripgrep                         # better grep
        # lua-language-server             # lua lsp
        clang                           # c lsp
        make                            # make
        # tinymist                        # typst lsp
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

        # General
        chromium                        # browser
        discord                         # messaging
        inkscape                        # PDF editor
        obs-studio                      # recorder
        godot                           # game engine
        lazygit                         # git tui
        nodejs                          # javascript
        npm                             # js package manager
        gcc                             # libc
        dunst                           # notification daemon
        vlc                             # video player
        zip                             # archive tool
        unzip                           # archive tool
        7zip                            # archive tool
        eza                             # better ls
        zoxide                          # better cd
        bat                             # better cat
        bottom                          # better top
        sagemath                        # calculator
        nmap                            # network listener
        socat                           # network listener
        file                            # file inspection
        which                           # binary locator
        tree                            # file tree
        wget                            # HTTP requests
        glow                            # terminal MD renderer
        strace                          # stack trace
        ltrace                          # stack trace
        typst                           # typsetting language
        zsh                             # shell
        zsh-syntax-highlighting         # syntax highlighting for zsh
        zsh-autocomplete                # autocomplete for zsh
        starship                        # prompt manager
        openvpn                         # vpn
        obsidian                        # notes
        ghc                             # haskell
        stow                            # symlink farm
        keyd                            # key remapping
        tmux                            # terminal multiplexer
        python                          # python
        python-pip                      # python package manager
        nix                             # nix (`extra-experimental-features = nix-command flakes` to /etc/nix/nix.conf)
        docker                          # docker
        gnu-netcat                      # nc
        fastfetch                       # fetch

        # Fonts
        # ttf-font-awesome
        # powerline-fonts
        nerd-fonts
    )
    # sudo pacman -Syu --noconfirm
    echo "${packages[@]}"
    sudo pacman -S --needed --noconfirm "${packages[@]}"


    # AUR packages
    aur_packages=(
        vesktop-bin                     # messaging (https://github.com/refact0r/system24)
        whatsapp-for-linux              # messaging
        qview                           # image viewer
        lean4-bin                       # lean
        wlogout                         # logout manager
    )
    # yay -Syu --noconfirm
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


# ----- Copy Config Files -----
read -n1 -rep 'Would you like to copy config files? (y,n)' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "Copying config files...\n"
    sudo stow --dotfiles -t "$HOME" hypr nvim tmux waybar zsh alacritty starship wlogout vesktop yazi
    sudo stow --dotfiles -t "/" greetd keyd
fi


# ----- Services -----
read -n1 -rep 'Would you like to start your services? (y,n)' SRVC
if [[ $SRVC == "Y" || $SRVC == "y" ]]; then

    sudo systemctl enable --now docker

    if [[ "$SHELL" != "/bin/zsh" ]]; then
        echo -e "Changing default shell to zsh...\n"
        chsh -s /bin/zsh
    else
        echo -e "Default shell is already zsh. Skipping chsh...\n"
    fi
    # Oh-my-zsh setup here


    echo -e "Changing default browser to firefox...\n"
    xdg-settings set default-web-browser firefox.desktop


    echo -e "Tmux setup...\n"
    mkdir -p "$HOME/.tmux/plugins"
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi


    echo -e "Starting the Sound Services...\n"
    # sudo systemctl enable --now pipewire pipewire-pulse wireplumber
    systemctl --user enable --now pipewire pipewire-pulse wireplumber
    sleep 2


    echo -e "Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2


    echo -e "Cleaning out conflicting xdg portals...\n"
    sudo pacman -Rns --noconfirm --quiet xdg-desktop-portal-gnome xdg-desktop-portal-gtk 2>/dev/null


    echo -e "Enabling greeter...\n"
    sudo systemctl enable greetd
    sleep 2
    if ! getent passwd greeter > /dev/null; then
        sudo useradd -m -G video greeter
        sudo passwd -d greeter
    fi


    echo -e "Enabling keyd...\n"
    sudo systemctl enable --now keyd
    sleep 2


    echo -e "Updating desktop database...\n"
    update-desktop-database "$HOME/.local/share/applications/"
    sleep 2
fi


# ----- Script is done -----
echo -e "Script had completed!!!\n"
