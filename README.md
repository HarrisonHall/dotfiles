# dotfiles

Modern .dotfiles and configuration. This is designed for new setups using
[nix](https://nixos.org/). Most configuration is placed outside of nix for
compatibility with non-nix systems.

## Setup

### NixOS

1. `nix-shell`
2. Add unstable channel
   - `sudo nix-channel --add https://nixos.org/channels/nixos-25.11 nixos`
   - `sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable`
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
- Query package dependencies: `nix-store -q --tree (which <package>)`

### Rust

- `rustup update`
- `rustup component add rust-analyzer`
- `rustup toolchain install stable`
- `rustup toolchain install nightly`

### SSH

- Create your ssh key `ssh-keygen -t ed25519 -a 32 -f ~/.ssh/id_ed25519`
- Symlink to default `ln -s ~/.ssh/id_ed25519 ~/.ssh/default`
- Add to servers:
  - `ssh-copy-id -i ~/.ssh/id_ed25519 hachha@home-server`
  - `ssh-copy-id -i ~/.ssh/id_ed25519 root@web-server`

### Keybinds

- `[Super]+?` - View keybindings

### Configuration

- Use something like `nwg-look` to ensure (GTK) styles are applied correctly

## TODO

- VT shell - setvtrgb
- Grub - grub2-mkdfont pf2
