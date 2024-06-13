#!/bin/bash
set -e

# Grab script folder
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Inital setup
mkdir -p ~/.config

function install_config_folder() {
	# Get name from arg
	name=$1

	# Other useful vars
	target_path=~/.config/$name
	backup_path=$target_path.bak
	source_path=$SCRIPT_DIR/$name

	# Test if symlink already pointing at correct folder
	hash readlink >/dev/null || {
		echo "readlink command required"
		exit
	}
	link_path=$(readlink $target_path) || true
	if [ "$link_path" = "$source_path" ]; then
		echo "Config for $name already installed at $target_path"
		return
	fi

	# Make backup if existing folder
	if [ -e $target_path ]; then
		if [ -e $backup_path ]; then
			echo "Backup file $backup_path already exists, skipping..."
			return
		else
			mv $target_path $backup_path
			echo "Existing $name config backed up to $backup_path."
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
