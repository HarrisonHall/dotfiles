# Podman configuration

{ lib, pkgs, user, ... }:

{
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.containers.registries.search = [ "docker.io" ];

  environment.systemPackages = with pkgs; [
    # buildah
    kubernetes  # k8s, 'nuf said
    kubernetes-helm  # Helm
    openshift  # okd, opinionated k8s
    opentofu  # Cooler terraform
    podman-compose  # Better docker-compose
    skopeo  # Manage containers
  ];

  users.users.${user} = {
   extraGroups = [ "docker" ];
  };
}
