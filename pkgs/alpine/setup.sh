#!/usr/bin/env sh

# Alpine setup.

# Installation requires:
# 1. Boot media: setup-alpine.
# 2. Boot media: setup-desktop (sway).
# 3. Reboot.
# 4. (user) `apk install git`.
# 5. (user) `git clone https://github.com/harrisonhall/dotfiles`.
# 6. (user) RUN THIS SCRIPT.
# 7. Reboot.
# 8. (user) nix-shell: just install-shell.
# 9. (user) setup syncthing http://127.0.0.1:8384.

SCRIPTPATH=$(dirname $(readline -f "$0"))

# Install core packages.
doas apk add \
  alpine-locales bind-tools libc6-compat gcompat build-base \
  bash curl git less python3 xz \
  mandoc mandoc-doc man-pages docs lang \
  networkmanager network-manager-applet networkmanager-wifi networkmanager-tui networkmanager-cli \
  fish tmux \
  dbus dbus-x11 flatpak libnotify xdg-desktop-portal xdg-desktop-portal-wlr xdg-user-dirs xdg-utils \
  pavucontrol pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber \
  grim mako slurp swaybg rofi-wayland waybar wdisplays \
  font-awesome font-noto font-misc-misc \
  nautilus gvfs \
  papirus-icon-fonts wezterm wezterm-fonts vlc \
  steam-devices \
  alsa-lib alsa-lib-dev \
  udisks2 udisks2-doc autofs dosfstools exfat usbutils \
  pm-utils acpid \
  terminus-font \
  syncthing syncthing-openrc \
  clang glfw-dev libc-dev pkgconf wayland-dev \
  podman podman-compose

doas apk add \
  fontconfig \
  xorgproto libxkbcommon libxkbcommon-dev xkbcomp xkbcli xkeyboard-config \
  glfw glfw-dev libx11 libx11-dev libxcursor-dev libxrandr-dev libinput-dev libinput xinput  libxi-dev \
  raylib raylib-dev \
  mesa-gl libxkbcommon libva-glx libva-glx-dev libxkbcommon-dev sdl2-dev sdl12-compat-dev

# Others?
# thunar thunar-volman

# User setup.
doas chsh -s /usr/bin/fish
doas addgroup $USER audio
doas addgroup $USER disk
doas addgroup $USER plugdev
doas addgroup $USER seat
doas addgroup $USER syncthing
doas addgroup $USER users
doas addgroup $USER video

# Establish services.
doas rc-update add consolefont boot
doas rc-update add acpid default
doas rc-update add networkmanager default
doas rc-update del syncthing

crontab $SCRIPTPATH/crontab

# Locale.
cat /etc/profile.d/00locale.sh /etc/profile.d/20locale.sh | doas tee /etc/profile.d/locale.sh > /dev/null
echo "export LC_ALL=en_US.UTF-8" | doas tee -a /etc/profile.d/locale.sh > /dev/null
doas sed -i "s|C.UTF-8|en_US.UTF-8|" /etc/profile.d/locale.sh

# Command permissions
echo -e "\npermit nopass hachha as root cmd /sbin/reboot" | doas tee -a /etc/doas.d/doas.conf > /dev/null
echo -e "permit nopass hachha as root cmd /sbin/poweroff" | doas tee -a /etc/doas.d/doas.conf > /dev/null
echo -e "permit nopass hachha as root cmd /usr/sbin/pm-suspend" | doas tee -a /etc/doas.d/doas.conf > /dev/null

# tty font (-d == DOUBLE SIZE)
# echo -e "[main]\ndhcp=internal\nplugins=ifupdown,keyfile\n[ifupdown]\nmanaged=true\n[device]\nwifi.scan-rand-mac-address=yes\nwifi.backend=wpa_supplicant" | doas tee /etc/NetworkManager/NetworkManager.conf > /dev/null
doas setfont -d /usr/share/consolefonts/ter-v32b.psf.gz
# TODO: edit /etc/conf.d/consolefont.

# Network manager.
doas mkdir -p /etc/NetworkManager/conf.d
echo -e "[main]\ndhcp=internal\nplugins=ifupdown,keyfile\n[ifupdown]\nmanaged=true\n[device]\nwifi.scan-rand-mac-address=yes\nwifi.backend=wpa_supplicant" | doas tee /etc/NetworkManager/NetworkManager.conf > /dev/null
echo -e "[main]\nauth-polkit=false" | doas tee /etc/NetworkManager/conf.d/any-user.conf > /dev/null
doas rc-update add networkmanager default
doas rc-update del networking boot
doas rc-update del wpa_supplicant boot

# TODO: Install flatpaks (steam, discord, calibre, anki, etc.)
# TODO: https://wiki.alpinelinux.org/wiki/Suspend_on_LID_close
# TODO: https://github.com/catppuccin/tty
# doas grub-mkconfig -o /boot/grub/grub.cfg

# Setup nix.
doas mkdir -m 0755 /nix && doas chown hachha /nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Rust.
# rustup install stable
# rustup component add rust-analyzer
