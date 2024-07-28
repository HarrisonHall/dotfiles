# Podman configuration

{ lib, pkgs, user, ... }:

{
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.containers.registries.search = [ "docker.io" ];

  environment.systemPackages = with pkgs; [
    podman-compose  # Better docker-compose
  ];

  users.users.${user} = {
   extraGroups = [ "docker" ];
  };
}
