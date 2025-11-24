# Security configuration

{ config, pkgs, lib, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    # Crypt
    protonvpn-gui
    # protonvpn-cli  # Deprecated
    protonmail-bridge

    # Signal messaging
    signal-desktop

    # Tor
    tor
    tor-browser
    mullvad
    mullvad-vpn
    mullvad-browser
  ];
}
