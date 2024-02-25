# configW
Modern .dotfiles and configuration.
This is designed for new setups using [nix](https://nixos.org/).

## Setup
### NixOS
1. `sudo ./build_nixos.sh`
2. Custom setup:
   - Set password `passwd`

### *nix
0. Install nix: `sh <(curl -L https://nixos.org/nix/install) --daemon`
1. Update profile: `./build_shell.sh`
2. Custom setup:
   - Install gui programs: firefox, discord, obsidian, thunderbird, vlc...

## Notes & Issues
### command-not-found
```sh
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update
```

## Tips

### Nix
- Try program temporarily: `nix-shell -p <program/package>`
- Package lookup: [nixpkgs](https://search.nixos.org/packages)

### Rust
- `rustup update`
- `rustup toolchain install stable`
- `rustup toolchain install nightly`
