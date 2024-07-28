# Terminal configuration (extra)

{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Language
    ## Compilers & Interpreters
    gcc  # GCC
    llvmPackages_15.libclang  # Clang
    patchelf  # Patch binaries
    zig  # Zig toolchain
    ## LSP
    nil  # Nix LSP

    # Core utils
    ffmpeg_5-full  # Manage video
    gparted  # Disk management
    imagemagick  # Image commands like convert
    pandoc  # File conversion
    slides  # Markdown presentation tool
    wireguard-tools  # Wireguard CLI
    xsel  # X selection util
    
    # Dev utils
    pkg-config
    alsa-lib
    udev

    # Python packages
    (python3.withPackages(ps: with ps; [ 
      cryptography
      dnspython
      pandas
      pip
      "python-lsp-server[all]"
      requests
    ]))
  ];
}
