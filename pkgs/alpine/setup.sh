#!/usr/bin/env sh

# Installation requires:
# 1. Boot media: setup-alpine
# 2. Boot media: setup-desktop (sway)
# 3. Reboot
# 4. (user) apk install git
# 5. (user) `git clone https://github.com/harrisonhall/dotfiles`
# 6. (user) RUN THIS SCRIPT
# 7. Reboot.
# 8. (user) nix-shell: just install-shell

# Install core packages.
doas apk install \
  alpine-locales bind-tools libc6-compat build-base \
  bash curl git less python3 xz \
  man-pages docs network-manager-applet \
  fish tmux \
  dbus dbus-x11 flatpak xdg-desktop-portal xdg-desktop-portal-wlr xdg-user-dirs \
  pavucontrol pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber \
  grim mako slurp rofi-wayland waybar wdisplays \
  font-awesome font-noto font-misc-misc \
  nautilus papirus-icon-fonts wezterm wezterm-fonts vlc \
  steam-devices \
  udisks2 udisks2-doc autofs dosfstools exfat usbutils \
  pm-utils apcid \
  terminus-font \
  clang glfw-dev libc-dev pkgconf wayland-dev 

# User setup.
doas chsh -s /usr/bin/fish
doas addgroup $USER audio
doas addgroup $USER disk
doas addgroup $USER seat
doas addgroup $USER users
doas addgroup $USER video

# Start services.
doas rc-update add acpid

# Locale.
cat /etc/profile.d/00locale.sh /etc/profile.d/20locale.sh | doas tee /etc/profile.d/locale.sh > /dev/null
echo "export LC_ALL=en_US.UTF-8" | doas tee -a /etc/profile.d/locale.sh > /dev/null
doas sed -i "s|C.UTF-8|en_US.UTF-8|" /etc/profile.d/locale.sh

# tty (TODO: Still _too_ small!)
doas setfont /usr/share/consolefonts/ter-v32b.psf.gz

# TODO: Install flatpaks (steam, anki, etc.)
# TODO: dbus-launcher in /etc/profile
# TODO: https://wiki.alpinelinux.org/wiki/Suspend_on_LID_close
# TODO: https://github.com/catppuccin/tty
# doas grub-mkconfig -o /boot/grub/grub.cfg

# Setup nix.
doas mkdir -m 0755 /nix && doas chown hachha /nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Rust.
# rustup install stable
# rustup component add rust-analyzer
