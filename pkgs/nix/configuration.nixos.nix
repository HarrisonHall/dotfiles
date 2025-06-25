# configuration.nix
## Nix configuration
## Check `man configuration.nix` or nixos manual (`nixos-help`)

{ config, pkgs, lib, passthru, stdenv, ... }:

let
  user = "harrison";  

in
{
  _module.args.user = user;
  imports =
    [ 
      # Hardware
      # ./hardware/framework-13.nix
      ./hardware/desktop.nix
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
      ./pkgs/custom/podman.nix
      ./pkgs/custom/steam.nix
      ./pkgs/custom/sway.nix
      ./pkgs/custom/niri.nix
      ./pkgs/custom/syncthing.nix
      ./pkgs/custom/vm.nix
    ];

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  # Allow flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      # "video=1920x1080"
      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
    ];
    consoleLogLevel = 3;
    initrd.verbose = false;
    loader.timeout = 0;  # Press any key to load the bootloader list
    plymouth = {
      enable = true;
      themePackages = [
        (pkgs.catppuccin-plymouth.override { variant = "mocha"; })
      ];
      theme = "catppuccin-mocha";
    };
  };
  console.colors = [
    "1e1e2e" # base
    "181825" # mantle
    "313244" # surface0
    "45475a" # surface1
    "585b70" # surface2
    "cdd6f4" # text
    "f5e0dc" # rosewater
    "b4befe" # lavender
    "f38ba8" # red
    "fab387" # peach
    "f9e2af" # yellow
    "a6e3a1" # green
    "94e2d5" # teal
    "89b4fa" # blue
    "cba6f7" # mauve
    "f2cdcd" # flamingo
  ];

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
  environment.variables.VISUAL = "kate";

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
  system.stateVersion = "25.05";  # nixos version
}

