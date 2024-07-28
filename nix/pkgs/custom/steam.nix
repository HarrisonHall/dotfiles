{ lib, pkgs, ... }:

{
  programs.steam.enable = true;

  hardware.opengl.enable = true;
  # hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;  # May be necessary for steam

  environment.systemPackages = with pkgs; [
    vulkan-loader
  ];
}
