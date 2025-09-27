# Core packages configuration.

{ config, pkgs, lib, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    # Essential
    discord  # Discord, but with more features!
    firefox  # Browser
    ghostty  # Terminal

    # Utils
    # calibre  # ebook software
    # element-desktop  # Element [MATRIX]
    feh  # View images
    nautilus  # File explorer
    halloy  # IRC
    imhex  # Hex viewer
    kodi-wayland  # Entertainment center
    obs-studio  # Capture audio and video
    pinta  # Basic image editor
    thunderbird-bin  # Thunderbird
    vlc  # Audio-video viewer
    wezterm  # Backup terminal
  ];
}
