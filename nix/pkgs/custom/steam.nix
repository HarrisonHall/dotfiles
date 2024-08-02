{ lib, pkgs, ... }:

{
  programs.steam.enable = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;  # May be necessary for steam

  environment.systemPackages = with pkgs; [
    vulkan-loader
  ];
}
