#!/usr/bin/env sh
## build.sh
configw="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

# Update configuration
echo "- Symlinking"
./scripts/symlink_all.sh $configw

# NIX
echo "- Building config"
sudo nixos-rebuild switch -I nixos-config="${configw}/nix/configuration.nix" --upgrade
# --upgrade --show-traces  # TODO - turn into flags

## Run GC on success
if [ $? -eq 0 ]; then
    echo "- Running garbage collection"
    nix-env --delete-generations 14d
    # nix-collect-garbage -d
    nix-store --gc
fi
