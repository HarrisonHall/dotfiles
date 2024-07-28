# Networking settings

{ config, lib, pkgs, modulesPath, user, ... }:

{
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;  # nmapplet
  services.gnome.gnome-keyring.enable = true;  # Remember passwords
  security.pam.services.greetd.enableGnomeKeyring = true;  # Unlock keyring on login (for greetd)
  networking.wireguard.enable = true;

  users.users.${user} = {
   extraGroups = [ "network" "networkmanager" ];
  };
}
