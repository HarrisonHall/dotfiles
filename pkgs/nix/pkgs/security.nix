# Security configuration

{ config, pkgs, lib, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    # Crypt
    # protonvpn-gui
    # protonmail-bridge

    # Signal messaging
    signal-desktop

    # Tor
    tor
    tor-browser
    # mullvad
    # mullvad-vpn
    # mullvad-browser

    # PIV
    yubikey-manager
    yubico-piv-tool
  ];
}
