# Terminal configuration (core)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Shell
    fish  # Friendly Interactive Shell

    # Editor
    helix  # "Post-modern" editor

    # Coding
    git  # Git
    gh  # Github cli
    jujutsu  # Jujutsu versioning cli
    mosh  # UDP SSH
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
    difftastic  # Diffing tool (for git)
    direnv  # Manage environments based on directory (nix support)
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
    mergiraf  # Merge tool
    newsraft  # Feed viewing
    nitch  # Minimal fetching
    ripgrep  # Recursively search
    slides  # Markdown presentation tool
    starship  # Easy prompt
    # taskwarrior3  # TODOs
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
