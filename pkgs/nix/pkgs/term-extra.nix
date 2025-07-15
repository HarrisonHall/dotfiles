# Terminal configuration (extra)

{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Language
    ## Compilers & Interpreters
    gcc  # GCC
    llvmPackages_15.libclang  # Clang
    patchelf  # Patch binaries
    uv  # Python toolchains
    zig  # Zig toolchain
    ## LSP
    nil  # Nix LSP
    tinymist  # Typst LSP

    # Core utils
    ffmpeg-full  # Manage video
    gparted  # Disk management
    imagemagick  # Image commands like convert
    pandoc  # File conversion
    ripgrep-all  # rga = ripgrep + rich-text searching (pdf, docx, etc.)
    slides  # Markdown presentation tool
    taskwarrior3  # Tasks
    wireguard-tools  # Wireguard CLI
    xsel  # X selection util
    
    # Dev utils
    alsa-lib
    pkg-config
    udev

    # Extra tools
    localsend  # Send things on the same network
    mdbook  # Convert markdown to books

    # Experimental
    atuin
    bacon  # Rust compiler-driven development
    viddy
    hexyl
    dua
    procs
    fselect
    # tmuxinator  # Replaced with tmuxp

    # Python packages
    python312Packages.python-lsp-server
    (python3.withPackages(ps: with ps; [ 
      cryptography
      dnspython
      pandas
      pip
      requests
    ]))
  ];
}
