# Mounting settings

{ config, lib, pkgs, user, ... }:

{
  # Enable automounting
  # services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    exfat
  ];
}
