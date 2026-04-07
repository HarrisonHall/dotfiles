{ lib, pkgs, user, ... }:

{
  # services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.system76-scheduler.enable = true;

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
 
  # services.dbus.enable = true;
  # security.polkit.enable = true;

  # Security
  # security.polkit.enable = true;
  # services.xserver.enable = true;
  # services.xserver.dpi = 96;

  # environment.variables.XCURSOR_PATH = lib.mkDefault "$HOME/.icons:$HOME/.local/share/icons:$HOME/.nix-profile/share/icons:/usr/share/icons"; # "~/.nix-profile/bin/<your app>";

}
