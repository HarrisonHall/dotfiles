# dotfiles

Modern .dotfiles and configuration. This is designed for new setups using
[nix](https://nixos.org/). Most configuration is placed outside of nix for
compatibility with non-nix systems.

## Setup

### NixOS

1. `nix-shell`
2. Add unstable channel
   - `sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos`
   - `sudo nix-channel --update`
3. `just install`

### \*nix

1. Install nix: `sh <(curl -L https://nixos.org/nix/install) --daemon`
2. `nix-shell`
3. Update profile: `just install-shell`
4. Custom setup:
   - Install GUI programs: firefox, discord, obsidian, thunderbird, vlc...

### Manual setup

- Wallpaper is installed at `~/media/wallpapers/current.image`
- Set password `passwd`

## Tips

### Nix

- Try program temporarily: `nix-shell -p <program/package>`
- Package lookup: [nixpkgs](https://search.nixos.org/packages)

### Rust

- `rustup update`
- `rustup toolchain install stable`
- `rustup toolchain install nightly`

### Keybinds

- `[Super]+?` - View keybindings

### Configuration

- Use something like `nwg-look` to ensure (GTK) styles are applied correctly

## TODO

- VT shell - setvtrgb
- Grub - grub2-mkdfont pf2
