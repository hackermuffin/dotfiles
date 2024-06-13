#!/bin/bash

# Script to symlink all config files into the correct location

# Grab script folder
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# inital setup
mkdir -p ~/.config

function install_config_folder() {
	# Get name from arg
	name=$1

	# Make backup if existing folder
	if [ -e ~/.config/$name ]; then
		if [ -e ~/.config/$name.bak ]; then
			echo "Backup file ~/.config/$name.bak already exists, skipping..."
			return
		else
			mv ~/.config/$name ~/.config/$name.bak
			echo "Existing $name config backed up to ~/.config/$name.bak."
		fi
	fi

	# Symlink new folder
	ln -s $SCRIPT_DIR/$name ~/.config/$name
	echo "$name config installed to ~/.config/$name"
}

# nvim
install_config_folder nvim

# hyprland
install_config_folder hypr
install_config_folder waybar
