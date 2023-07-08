#!/usr/bin/env sh
## build.sh
configw=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Update configuration
echo "- Symlinking"
## Symlink configw
ln -s -T $configw ~/.config/configw >/dev/null 2>&1
## Symlink .config
for configuration in $(find "${configw}" -maxdepth 2 -path "*/.config/*"); do
    ln -s -T $configuration ~/.config/$(basename $configuration) >/dev/null 2>&1
done

# NIX
echo "- Building config"
sudo nixos-rebuild switch -I nixos-config="${configw}/nix/configuration.nix"
# --upgrade --show-traces  # TODO - turn into flags

## Run GC on success
if [ $? -eq 0 ]; then
    echo "- Running garbage collection"
    nix-env --delete-generations 14d
    nix-store --gc
fi