# Dev configuration

{ config, pkgs, lib, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    ## Editors
    kdePackages.kate
    vscode
    ## Other
    # (callPackage ./custom/cdtest.nix { })  # Manage temporary project directories
    obsidian  # GUI note manager
  ];
}
