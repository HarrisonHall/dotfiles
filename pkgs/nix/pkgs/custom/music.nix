{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mpd
    mpc
    euphonica
  ];
}
