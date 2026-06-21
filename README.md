# dotfiles

Modern .dotfiles and configuration. This is designed for new setups using
[nix](https://nixos.org/) and [mise](https://mise.jdx.dev/). Most configuration
is placed outside of nix for compatibility with non-nix systems.

## Setup

> [!NOTE]  
> If incorporating into an existing setup _or_ using a non-NixOS distro, it may
> be beneficial to utilize [\_bootstrap](pkgs/_bootstrap) before utilizing any
> of the instructions below.

### Mise

1. `curl https://mise.run | sh`
2. `mise trust`

### Packages

#### Mise

1. `mise install`

#### NixOS

1. `nix-shell`
2. Add unstable channel
   - `sudo nix-channel --add https://nixos.org/channels/nixos-25.11 nixos`
   - `sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable`
3. `mise run install-nixos update`

#### \*nix

1. Install nix: `sh <(curl -L https://nixos.org/nix/install) --daemon`
2. `nix-shell`
3. Update profile: `mise run install-shell update`
4. Custom setup:
   - Install GUI programs: firefox, discord, obsidian, thunderbird, vlc...

#### Flatpak

1. Install flatpak: (_distro-dependent_)
2. `mise install-flatpak`

### Manual setup

- Wallpaper is installed at `~/media/wallpapers/current.image`
- Set password `passwd`

## Tips

### Nix

- Try program temporarily: `nix-shell -p <program/package>`
- Package lookup: [nixpkgs](https://search.nixos.org/packages)
- Query package dependencies: `nix-store -q --tree (which <package>)`
- Run package via override expression:
  `nix-shell -p "(olympus.override { celesteWrapper = \"steam-run\"; })"`

### Rust

- `rustup update`
- `rustup component add rust-analyzer`
- `rustup toolchain install stable`
- `rustup toolchain install nightly`

After updates, sometimes it is useful to:
`rustup uninstall stable && rustup install stable && rustup component add rust-analyzer`.

### YubiKey

- Load existing certs:
  - `ssh-keygen -K`: dump keys
    - `cp id_ed25519_sk.yubi ~/.ssh/.`
  - Load the certificate:
    `yubico-piv-tool -a import-certificate -s 9a -i cert.pem`
  - Add to ssh: `ssh-add -K ./priv.key`
  - Add gpg: `gpg --import ./dotfiles/.gnupg/public-keys/signing.gpg.public`
  - ~~Add to ssh:
    `ssh-keygen -D /nix/var/nix/profiles/system/sw/lib/opensc-pkcs11.so -e`~~

### SSH

- Create local ssh key `ssh-keygen -t ed25519 -a 32 -f ~/.ssh/id_ed25519`
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
