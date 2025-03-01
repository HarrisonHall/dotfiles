# Dev configuration

{ config, pkgs, lib, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    ## Editor
    vscode
    ## Other
    (callPackage ./custom/cdtest.nix { })  # Manage temporary project directories
    obsidian  # GUI note manager
  ];
}
