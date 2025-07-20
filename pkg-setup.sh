#!/bin/bash

if [ ! -f "utils-setup.sh" ]; then
    echo "Error: missing Utils"
    exit 1
fi

source utils-setup.sh

if [ ! -f "packages.conf" ]; then
    echo "Error: no packages.conf"
    exit 1
fi

source packages.conf

echo "Updating arch"
sudo pacman -Syu --noconfirm

if ! command -v yay &> /dev/null; then
    echo "Installing yay from AUR"
    sudo pacman -S --needed base-devel --noconfirm
    git clone https://aur.archlinux.org/yay.git
    cd yay
    echo "Building"
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

echo "Installing Dev tool"
install_packages "${DEV_TOOLS[@]}"

echo "Installing System utils"
install_packages "${SYSTEM_UTILS[@]}"

echo "Installing Stuff"
install_packages "${STUFF[@]}"

echo "Installing Fontsf"
install_packages "${FONTS[@]}"

echo "Installing Yay pkg"
install_packages "${YAY_STUFF[@]}"


if [ ! -d "${ZSH:-$HOME/.oh-my-zsh}" ]; then
    echo "Installing Oh My Zsh..."
    cd
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cd ~/.oh-my-zsh/custom/plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions.git
    cd
fi

if ! command -v zsh >/dev/null &>; then
    echo "zsh is not installed"
    exit 1
fi

if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "changing default shell"
    chsh -s "$(command -v zsh)"
fi


echo "Setup complete"
