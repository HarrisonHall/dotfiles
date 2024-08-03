#!/usr/bin/env sh

## build.sh
dotfiles="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

# Update configuration
echo "- Symlinking"
./scripts/symlink_all.sh $dotfiles
./scripts/build_heir.sh

# NIX
echo "- Building config"
sudo nixos-rebuild switch -I nixos-config="${dotfiles}/nix/configuration.nix" -j 4
# --upgrade --show-traces  # TODO - turn into flags

## Run GC on success
if [ $? -eq 0 ]; then
    echo "- Running garbage collection"
    sudo nix-collect-garbage --delete-older-than 30d
    # sudo nix-env --delete-generations +5  # Keep last 5 generations
    sudo nix-store --gc
    # sudo nixos-rebuild boot
fi
