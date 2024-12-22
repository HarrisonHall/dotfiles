# Hobbies configuration

{ config, pkgs, lib, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    # Essential
    discord-canary
    firefox-wayland
    wezterm

    # Utils
    calibre  # ebook software
    element-desktop  # Element [MATRIX]
    feh  # View images
    nautilus  # File explorer
    halloy  # IRC
    imhex  # Hex viewer
    inkscape-with-extensions  # Inkscape
    obs-studio  # Capture audio and video
    pinta  # Basic image editor
    thunderbird-bin  # Thunderbird
    vlc  # Audio-video viewer
  ];
}
