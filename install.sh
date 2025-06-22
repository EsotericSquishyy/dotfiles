#! /usr/bin/env bash

# https://github.com/SolDoesTech/hyprland/blob/main/set-hypr

# -----Yay install-----
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
fi

# -----Disable wifi powersave mode-----
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

# -----Install all of the above pacakges-----
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
        firefox 
        hyprland
        alacritty

        # Neovim
        zathura
        fzf
        ripgrep
        lua-language-server
        clang
        make
        tinymist

        # Hyprland
        greetd
        greetd-tuigreet
        xdg-desktop-portal-hyprland
        polkit
        qt5-wayland
        qt6-wayland
        xdg-utils
        swww
        waybar
        thunar
        alsa-utils
        brightnessctl
        rofi-wayland
        slurp
        grim

        # General
        chromium
        discord
        inkscape
        obs-studio
        godot
        lazygit
        nodejs
        gcc
        dunst
        wl-clipboard
        vlc
        zip
        unzip
        7zip
        eza
        zoxide
        bat
        bottom
        sagemath
        imagemagick
        bind
        nmap
        socat
        file
        which
        tree
        wget
        glow
        # pulseaudio
        pipewire
        strace
        ltrace
        typst
        zsh
        bluez
        bluez-utils
        openvpn
        jellyfin-ffmpeg
        obsidian
        ghc
        stow
        keyd
        tmux

        # Fonts
        # ttf-font-awesome
        # powerline-fonts
        ttf-nerd-fonts-symbols
        ttf-nerd-fonts-symbols-mono
    )
    # sudo pacman -Syu --noconfirm
    echo "${packages[@]}"
    sudo pacman -S --needed --noconfirm "${packages[@]}"


    # AUR packages
    aur_packages=(
        neofetch
        whatsapp-for-linux
        qview
        lean4-bin
        wlogout
    )
    # yay -Syu --noconfirm
    yay -S --needed --noconfirm "${aur_packages[@]}"


    echo -e "Changing to zsh...\n"
    sudo chsh -s /bin/zsh "$(logname)"


    echo -e "Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2


    echo -e "Cleaning out conflicting xdg portals...\n"
    sudo pacman -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk


    # -----Copy Config Files-----
    read -n1 -rep 'Would you like to copy config files? (y,n)' CFG
    if [[ $CFG == "Y" || $CFG == "y" ]]; then
        echo -e "Copying config files...\n"
        sudo stow --dotfiles -t "$HOME" hypr nvim tmux waybar zsh
        # sudo mkdir -p /etc/greetd
        sudo stow --dotfiles -t "/" greetd keyd

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

    fi
fi

# -----Script is done-----
echo -e "Script had completed.\n"
