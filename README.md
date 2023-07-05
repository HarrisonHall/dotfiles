# configW
Modern .dotfiles and configuration. Designed for new setups using nixos and wayland.



## Setup or Update
1. `git clone https://github.com/HarrisonHall/configW`
2. `cd configw && sudo ./build.sh`
3. Custom setup:
   * Set password `passwd`

## command-not-found
```bash
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update
```

## Tips
- `command-not-found` error: ``
- Try program temporarily: `nix-shell -p <program/package>`