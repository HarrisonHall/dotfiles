# Syncthing configuration

{ lib, pkgs, user, ... }:

{
  services.syncthing = {
    enable = true;
    user = "${user}";
    dataDir = "/home/${user}/workspace/notes";    # Default folder for new synced folders
    configDir = "/home/${user}/.config/syncthing";   # Folder for Syncthing's settings and keys
  };
}
