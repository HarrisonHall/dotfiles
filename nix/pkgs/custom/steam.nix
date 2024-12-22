{ lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    #gamescopeSession.enable = true;   # Enables "SteamOS" session
  };

  programs.gamemode.enable = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;  # May be necessary for steam

  environment.systemPackages = with pkgs; [
    vulkan-loader

    dxvk
    #mangohud
    meson
    #steam-run
    #protonup-qt

    # Lutris
    libgpg-error
    libxml2
    lutris
    freetype
    gnutls
    openldap
    SDL2
    sqlite
    xml2

    pkgsi686Linux.gperftools   # required to run CS:Source
  ];

  # Creates Enviroment path for 32 bit gperftools, required to run CS:Source
  # Use with CS:Source commandline: gamemoderun LD_PRELOAD=$GPERF32_PATH/lib/libtcmalloc.so %command%
  environment.variables = rec {
    GPERF32_PATH="${pkgs.pkgsi686Linux.gperftools}";
  };
}
