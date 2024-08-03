# dotfiles

Modern .dotfiles and configuration. This is designed for new setups using
[nix](https://nixos.org/).

## Setup

### NixOS

1. Add unstable channel
   - `sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos`
   - `sudo nix-channel --update`
2. `sudo ./build_nixos.sh`
3. Custom setup:
   - Set password `passwd`

### \*nix

0. Install nix: `sh <(curl -L https://nixos.org/nix/install) --daemon`
1. Update profile: `./build_shell.sh`
2. Custom setup:
   - Install GUI programs: firefox, discord, obsidian, thunderbird, vlc...

## Tips

### Nix

- Try program temporarily: `nix-shell -p <program/package>`
- Package lookup: [nixpkgs](https://search.nixos.org/packages)

### Rust

- `rustup update`
- `rustup toolchain install stable`
- `rustup toolchain install nightly`

### Keybinds

- `cmd+?` - View keybinds
