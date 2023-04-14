#!/usr/bin/env sh
## build.sh

# Root check
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

# TODO - symlink dotfiles

# NIX
cp configuration.nix /etc/nixos/configuration.nix
nixos-rebuild switch # --upgrade  # TODO - upgrade flag

if [ $? -eq 0 ]; then
    nix-env --delete-generations 60d
    nix-store --gc
fi