# configuration.nix
## Nix configuration
## Check `man configuration.nix` or nixos manual (`nixos-help`)

{ config, pkgs, lib, passthru, ... }:

let
  user = "harrison";  

in
{
  _module.args.user = user;
  imports =
    [ 
      # Hardware
      ./hardware/framework-13.nix
      # System
      ./system/input.nix
      ./system/mounting.nix
      ./system/networking.nix
      ./system/sound.nix
      # Packages
      ./pkgs/core.nix
      ./pkgs/dev.nix
      ./pkgs/hobbies.nix
      ./pkgs/term-core.nix
      ./pkgs/term-extra.nix
      ./pkgs/custom/greeter.nix
      ./pkgs/custom/podman.nix
      ./pkgs/custom/steam.nix
      ./pkgs/custom/sway.nix
      ./pkgs/custom/syncthing.nix
    ];

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  # Allow flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "ntfs" ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable running "normal" linux packages with different linkers
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # TODO: Add any missing dynamic libraries for unpackaged programs here,
    # NOT in environment.systemPackages
  ];

  # Define user
  users.users.${user} = {
     isNormalUser = true;
     extraGroups = [ "video" "wheel" ];
     initialPassword =  "password";
     shell = pkgs.fish;
  };

  programs.fish.enable = true;
  environment.variables.EDITOR = "hx";
  environment.variables.VISUAL = "code";

  system.copySystemConfiguration = true;  # Copy this to /run/current-system/configuration.nix
  system.stateVersion = "24.05";  # nixos version
}

