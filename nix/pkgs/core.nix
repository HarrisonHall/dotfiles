# Hobbies configuration

{ config, pkgs, lib, user, ... }:

let
  masterTarball =
    fetchTarball https://github.com/NixOS/nixpkgs/archive/master.tar.gz;
in

{
  nixpkgs.config = {
    packageOverrides = pkgs: with pkgs; {
      master = import masterTarball {
        # config = config.nixpkgs.config;
      };
    };
  };
  users.users.${user}.packages = with pkgs; [
    # Essential
    discord-canary # Discord, but with more features!
    firefox  # Browser
    master.ghostty  # Terminal

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
    wezterm  # Backup terminal
  ];
}
