# Virtual machine configuration

{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qemu
  ];
}
