## build.sh


# Root check
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi


# NIX
cp configuration.nix /etc/nixos/configuration.nix
nixos-rebuild switch

# TODO - copy config
