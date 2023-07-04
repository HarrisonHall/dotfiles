#!/usr/bin/env sh
## build.sh
configw=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Update configuration
echo "- Symlinking"
## Symlink configw
ln -s $configw ~/.config/configw >/dev/null 2>&1
## Symlink .config
for configuration in $(find "${configw}" -maxdepth 2 -path "*/.config/*"); do
    ln -s $configuration "~/.config/$(basename $configuration)" >/dev/null 2>&1
done

# NIX
echo "- Building config"
sudo cp "${configw}/configuration.nix" /etc/nixos/configuration.nix
sudo nixos-rebuild switch # --upgrade  # TODO - upgrade flag
## Run GC on success
if [ $? -eq 0 ]; then
    echo "- Running garbage collection"
    nix-env --delete-generations 14d
    nix-store --gc
fi