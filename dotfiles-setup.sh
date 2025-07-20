#!/bin/bash

source packages.conf

is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

cd ~/.dotfiles

for s in "${STOW[@]}"; do
	if [[ "$1" == "--dry" ]]; then
		echo "[dry] Stow $s"
	else
		echo "Stowing $s"
		stow $s
	fi
done
