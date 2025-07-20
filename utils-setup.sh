 #!/bin/bash

is_installed() {
    pacman -Qi "$1" &>/dev/null
}

is_in_repo() {
    pacman -Si "$1" &>/dev/null
}

install_packages() {
    local to_pacman=()
    local to_yay=()

    for pkg in "$@"; do
        if is_installed "$pkg"; then
            echo "${pkg} Already installed"
            continue
        fi

        if is_in_repo "$pkg"; then
            to_pacman+=("$pkg")
        else
            to_yay+=("$pkg")
        fi
    done

    if [ ${#to_pacman[@]} -ne 0 ]; then
        echo "Installing with pacman: ${to_pacman[*]}"
        sudo pacman -S --noconfirm "${to_pacman[@]}"
    fi

    if [ ${#to_yay[@]} -ne 0 ]; then
        echo "Installing with yay: ${to_yay[*]}"
        yay -S --noconfirm "${to_yay[@]}"
    fi
}   
