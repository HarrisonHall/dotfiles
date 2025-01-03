# Terminal configuration (core)

let

  pkgs2405 = import (fetchTarball https://nixos.org/channels/nixos-24.05/nixexprs.tar.xz) { };

in

{ pkgs, ... }:

{
  services.lorri.enable = true;
  environment.systemPackages = with pkgs; [
    # Shell
    fish  # Friendly Interactive Shell

    # Editor
    helix  # Helix editor

    # Coding
    git  # Git
    gh  # Github cli
    jujutsu  # Jujutsu versioning cli
    onefetch  # Git repo visualizer

    # Language
    ## Compilers & Interpreters
    rustup  # Manage rust toolchains
    typst  # Latex alternative
    ## LSP
    ltex-ls  # Tex/Markdown spellcheck
    marksman  # Markdown LSP
    nodePackages.prettier  # Prettier

    # Core utils
    bash  # Legacy shell for use with scripts
    bat  # Cat with wings
    bottom  # Modern top utility
    colordiff  # Diff- with color!
    delta  # Diffing tool (for git)
    # pkgs2405.direnv  # Manage environments based on directory (nix support)
    du-dust  # Disk usage
    eza  # Better ls (ll)
    fastfetch  # Fetching tool
    fd  # Better find
    file  # Get information on files
    fzf  # Fuzzy file searching
    gnupg  # PGP/GPG signing
    just  # Justfile executor
    jq  # JSON tool
    kbd  # Keyboard & virtual terminal utils
    macchina  # Fetch tool
    # newsboat  # Feed viewing
    newsraft  # Feed viewing
    nitch  # Minimal fetching
    ripgrep  # Recursively search
    slides  # Markdown presentation tool
    starship  # Easy prompt
    tealdeer  # tldr
    tokei  # Code counter
    tmux  # Terminal multiplexer
    tmuxp  # tmux manager
    tree  # Display directory structure tree
    wget  # Network downloader
    yazi  # CLI file manager
    zellij  # Terminal multiplexer
    zip  # Zipping
    unzip  # Unzipping
    p7zip  # 7z
    xdg-utils  # Application opening/desktop integration
    yt-dlp  # Youtube+ downloader
    zk  # CLI note manager
    zoxide  # Better cd
  ];
}
