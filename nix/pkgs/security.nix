# Security configuration

{ config, pkgs, lib, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    # Crypt
    protonvpn-gui
    protonvpn-cli
    protonmail-bridge

    # Signal messaging
    signal-desktop
  ];
}
