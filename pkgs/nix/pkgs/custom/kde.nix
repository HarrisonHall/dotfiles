{ lib, pkgs, user, ... }:

{
  services.desktopManager.plasma6 = {
    enable = true;
  };
  services.xserver.enable = true;
}
