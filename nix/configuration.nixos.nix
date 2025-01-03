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
      ## Core
      ./pkgs/core.nix
      ./pkgs/dev.nix
      ./pkgs/hobbies.nix
      ./pkgs/security.nix
      ./pkgs/term-core.nix
      ./pkgs/term-extra.nix
      ## Custom
      ./pkgs/custom/greeter.nix
      ./pkgs/custom/grub.nix
      ./pkgs/custom/podman.nix
      ./pkgs/custom/steam.nix
      ./pkgs/custom/sway.nix
      ./pkgs/custom/syncthing.nix
      ./pkgs/custom/vm.nix
    ];

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  # Allow flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot
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
    extraGroups = [ "video" "wheel" "seat" ];
    initialPassword =  "password";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  environment.variables.EDITOR = "hx";
  environment.variables.PAGER = "bat";
  environment.variables.VISUAL = "code";

  security.sudo.enable = true;
  security.doas.enable = true;
  security.doas.extraRules = [{
    users = [ "${user}" ];
    # Optional, retains environment variables while running commands 
    # e.g. retains your NIX_PATH when applying your config
    keepEnv = true; 
    persist = true;  # Optional, only require password verification a single time
  }];

  system.copySystemConfiguration = true;  # Copy this to /run/current-system/configuration.nix
  system.stateVersion = "24.11";  # nixos version
}

