{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mpd  # Music player daemon.
    mpc  # Music player client.
    rmpc  # Modern music player client.
    euphonica  # GUI music player client.
    mopidy  # Jellyfin bridge for mpd.
  ];
}
