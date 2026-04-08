# Terminal configuration (extra)

{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Language
    ## Compilers & Interpreters
    gcc  # GCC
    # libclang  # Clang
    patchelf  # Patch binaries
    ## LSP
    nil  # Nix LSP
    tinymist  # Typst LSP
    ## Toolchains
    platformio-core

    # Core utils
    ffmpeg-full  # Manage video
    gparted  # Disk management
    imagemagick  # Image commands like convert
    pandoc  # File conversion
    slides  # Markdown presentation tool
    wireguard-tools  # Wireguard CLI
    xsel  # X selection util
    
    # Dev utils
    alsa-lib
    pkg-config
    udev

    # Extra tools
    atomicparsley  # Music metadata editor
    localsend  # Send things on the same network
    mdbook  # Convert markdown to books
    monolith  # Archive web-pages
    yt-dlp  # Youtube+ downloader
  ];
}
