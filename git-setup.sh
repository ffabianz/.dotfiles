#!/usr/bin/env bash

if ! pacman -Qi git; then
	echo "Install git"
	exit 1
fi

git config --global core.editor nvim
git config --global push.autoSetupRemote true
git config --global push.followTags true
git config --global gpg.format ssh
git config --global commit.gpgsign true
git config --global core.pager cat 
git config --global column.ui auto
git config --global branch.sort -committerdate
git config --global tag.sort version:refname

if ! command -v ssh-keygen; then
	echo "Install openssh"
	exit 1
fi

read -p "enter email: " user_email
echo "Email set to $user_email"

ssh-keygen -t ed25519 -C "$user_email"

file=`ls -d $HOME/.ssh/* | grep .pub`

git config --global user.signingkey "$file"

read -p "Enter full name: " user_full_name

git config --global user.email "$user_email"
git config --global user.name "$user_full_name"

echo "Git set up!"
