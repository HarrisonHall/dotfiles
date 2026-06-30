# Terminal configuration (core)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Most core tools are located in the mise config.
    # Tools here are either not installable via mise, or so fundamental it is
    # worth having them in both places.
    
    # Shell
    unstable.fish  # Friendly Interactive Shell
    unstable.nushell  # Modern shell
    bash  # Legacy shell for use with scripts

    # Core tools
    git  # 'nuff said
    mosh  # UDP SSH
    tree  # Display directory structure tree

    # Core utilities
    colordiff  # Diff- with color!
    file  # Get information on files
    gnupg  # PGP/GPG signing
    python314  # Python
    p7zip  # 7z
    wget  # Network downloader
    xdg-utils  # Application opening/desktop integration
    zip  # Zipping
    unzip  # Unzipping

    # Additional tools
    # ltex-ls  # Tex/Markdown spellcheck
    # prettier  # Prettier
    # vale  # Spellcheck and grammer
    # vale-ls  # vale LSP
    kbd  # Keyboard & virtual terminal utils
    macchina  # Fetch tool
    nitch  # Minimal fetching
    slides  # Markdown presentation tool    
    # ouch  # Handy compression tool
    # systemctl-tui  # Experimental

    # bacon  # Rust compiler-driven development
    # direnv  # Manage environments based on directory (nix support)
    # taskwarrior3  # Tasks
    # zellij  # Terminal multiplexer
  ];
}
