#!/bin/bash

# Script to symlink all config files into the correct location

# nvim
mv ~/.config/nvim/ ~/.config/nvim.orig/
ln -s $PWD/nvim ~/.config/nvim
