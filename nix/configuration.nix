# configuration.nix
## Nix configuration
## Check `man configuration.nix` or nixos manual (`nixos-help`)

{ config, pkgs, lib, ... }:

let
  user = "harrison";
  
  # DBUS sway helper
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # GTK sway helper
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Macchiato-Standard-Blue-Dark"
        gsettings set org.gnome.desktop.interface cursor-theme "Catppuccin-Macchiato-Dark-Cursors"
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
        gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
        '';
  };

  # Catppuccin
  catppuccin-gtk-custom = pkgs.catppuccin-gtk.override {
    variant = "macchiato";
    accents = [ "blue" ];
    size = "standard";  # compact
    tweaks = [ "rimless" "normal" ]; # black
  };
  catppuccin-cursors = pkgs.catppuccin-cursors.macchiatoDark;

in
{
  imports =
    [ 
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      <nixos-hardware/framework/13-inch/12th-gen-intel>
    ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;  # May be necessary for steam

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["mem_sleep_default=deep"];
  boot.loader.grub.device = "/dev/sda";
  boot.supportedFilesystems = [ "ntfs" ];

  # services.fprintd.enable = true;  # Fingerprint support

  networking.hostName = "hachha-laptop-nixos"; # hostname
  # Pick only one of the below networking options.
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;  # nmapplet
  services.gnome.gnome-keyring.enable = true;  # Remember passwords
  security.pam.services.greetd.enableGnomeKeyring = true;  # Unlock keyring on login (for greetd)

  # Set your time zone.
  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };
  fonts.packages = with pkgs; [
    fira  # Sans font (en)
    mplus-outline-fonts.githubRelease  # Backup sans (en, jp)
    noto-fonts  # Serif font (en)
    noto-fonts-cjk-serif  # Serif font (jp)
    hackgen-nf-font  # Monospace font w/ symbols (en, jp)
    font-awesome  # Backup symbols
    # monofur-nerdfont  # Backup monospace font
    # noto-fonts-emoji noto-fonts-monochrome-emoji  # Backup emoji fonts
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "HackGen35 Console NF"
      "M PLUS 1 CODE"
      "Font Awesome 6 Free"
      "Font Awesome 6 Brands"
    ];
    sansSerif = [
      "M PLUS 1"
      "Fira Sans"
      "Font Awesome 6 Free"
      "Font Awesome 6 Brands"
    ];
    serif = [
      "Noto Serif"
      "Noto Serif CJK JP"
      "M PLUS 1"
      "Font Awesome 6 Free"
      "Font Awesome 6 Brands"
    ];
  };

  # Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.base = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      # Configuration
      catppuccin-cursors  # Cursor
      # catppuccin-gtk  # GTK theme
      catppuccin-gtk-custom
      catppuccin-qt5ct  # QT theme
      configure-gtk  # GTK configuration (custom)
      dbus-sway-environment  # DBUS environment (custom)
      papirus-icon-theme  # Icons

      # Libs
      glib # gsettings
      glfw
      glfw-wayland
      libnotify  # libnotify + notify-send
      mesa
      wayland  # Wayland libs
      wayland-protocols  # Other wayland stuffs

      # Essential
      grim  # Screenshot tool
      mako  # Wayland notification daemon
      mate.mate-polkit  # Polkit
      networkmanagerapplet  # Network manager bar applet
      shared-mime-info  # Allow apps to have mime info
      swaylock  # Lock screen management
      swayidle  # Idle management
      waybar  # Better swaybar
      wl-clipboard  # Wayland clipboard utilities
      wtype  # Wayland type utility
      wf-recorder  # Wayland screen recorder
      xdg-user-dirs  # XDG help
      xdg-utils  # XDG

      # Scripting Utils
      acpi  # Battery
      slurp  # Screenspace selector
      swaybg  # Change sway bg
      swayr  # Simple cli for managing sway

      # Graphical Utils
      pavucontrol  # Audio control
      rofi-wayland  # Widgets and pickers
      rofi-emoji  # Emoji picker
      wdisplays # Configure displays
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
			# export QT_QPA_PLATFORM=wayland-egl
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
      export XMODIFIERS="@im=fcitx"
    '';
  };
  security.polkit.enable = true;
  security.pam.services.swaylock.text = ''
  auth include login
  '';
  security.pam.services.swaylock.failDelay = {
    enable = true;
    delay = 500000;  # 0.5s
  };
  services.xserver.enable = true;
  services.xserver.dpi = 96;

  # /etc/XXX
  environment.etc = {
    # GTK
    ## 2.0
    "xdg/gtk-2.0/gtkrc".text = lib.mkDefault ''
      gtk-theme-name="Catppuccin-Macchiato-Standard-Blue-Dark"
      gtk-icon-theme-name="Papirus-Dark"
      gtk-font-name="monospace 12"
      gtk-cursor-theme-name="Catppuccin-Macchiato-Dark-Cursors"
    '';
    "gtk-2.0/gtkrc".source = config.environment.etc."xdg/gtk-2.0/gtkrc".source;
    ## 3.0
    "xdg/gtk-3.0/settings.ini".text = lib.mkDefault ''
      [Settings]
      gtk-theme-name=Catppuccin-Macchiato-Standard-Blue-Dark
      gtk-icon-theme-name=Papirus-Dark
      gtk-font-name=monospace 12
      gtk-cursor-theme-name=Catppuccin-Macchiato-Dark-Cursors
      gtk-application-prefer-dark-theme=true
    '';
    "gtk-3.0/settings.ini".source = config.environment.etc."xdg/gtk-3.0/settings.ini".source;
    ## 4.0
    "xdg/gtk-4.0/settings.ini".text = lib.mkDefault ''
      [Settings]
      gtk-theme-name=Catppuccin-Macchiato-Standard-Blue-Dark
      gtk-icon-theme-name=Papirus-Dark
      gtk-font-name=monospace 12
      gtk-cursor-theme-name=Catppuccin-Macchiato-Dark-Cursors
      gtk-application-prefer-dark-theme=true
    '';
    "gtk-4.0/settings.ini".source = config.environment.etc."xdg/gtk-3.0/settings.ini".source;
  };

  # Default apps
  ## /etc/profiles/per-user/harrison/share/applications/
  # xdg.mimeApps = {
  #   enable = true;
  #   associations.added = {
  #     "application/pdf" = ["firefox.desktop"];
  #     "image/png" = [ "feh" "firefox.desktop" "gimp.desktop" ];
  #   };
  #   defaultApplications = {
  #     "application/pdf" = ["firefox.desktop"];
  #     "image/png" = [ "feh" "firefox.desktop" "gimp.desktop" ];
  #   };
  # };

  # Enable greetd-tuigreet minimal greeter
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };
  systemd.services.greetd = {
    unitConfig = {
         After = lib.mkOverride 0 [ "multi-user.target" ];
    };
    serviceConfig = {
      Type = "idle";
    };
  };

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;  # Recommended for pipewire
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable dbus
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  # Enable backlight support
  programs.light.enable = true;

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  # Allow flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.fish.enable = true;
  environment.variables.EDITOR = "hx";
  environment.variables.VISUAL = "code";
  environment.variables.XCURSOR_PATH = lib.mkDefault "$HOME/.icons:$HOME/.local/share/icons:$HOME/.nix-profile/share/icons:/usr/share/icons"; # "~/.nix-profile/bin/<your app>";

  # Enable automounting
  # services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Enable syncthing
  services.syncthing = {
    enable = true;
    user = "harrison";
    dataDir = "/home/${user}/workspace/notes";    # Default folder for new synced folders
    configDir = "/home/${user}/.config/syncthing";   # Folder for Syncthing's settings and keys
  };

  # Enable running "normal" linux packages with different linkers
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # TODO - add any missing dynamic libraries for unpackaged programs here,
    # NOT in environment.systemPackages
  ];

  # Define user
  users.users.${user} = {
     isNormalUser = true;
     extraGroups = [ "docker" "network" "networkmanager" "video" "wheel" ];
     initialPassword =  "password";
     shell = pkgs.fish;
     packages = with pkgs; [
        # Essential
        firefox-wayland
      	alacritty
 	      discord

        # Fonts
        font-manager
        
	      # CLI+
        ## Editor
        vscode
        ## Other
        broot  # Quickly jump around directories
        (callPackage ./pkgs/cdtest.nix { })  # Manage temporary project directories
        du-dust  # Disk-usage command
        hoard  # manage cli commands
        just  # Justfile executor
        mdp  # Markdown presentation tool
        tealdeer  # better manpages/tldr
        tokei  # Code counter
        obsidian  # Obsidian

        # Utils
        calibre  # ebook software
        element-desktop  # Element [MATRIX]
        feh  # View images
        gnome.nautilus  # File explorer
        halloy  # IRC
        inkscape-with-extensions  # Inkscape
        killall  # killall signaller
        vlc  # Audio-video viewerw
        obs-studio  # Capture audio and video
        thunderbird-bin  # Thunderbird
        wireguard-tools  # wireguard vpn

        # Crypt
        protonvpn-gui
        protonvpn-cli
        protonmail-bridge
        signal-desktop

        # Hobby
        anki-bin

        # Icons
        gnome.adwaita-icon-theme  # Used for firefox
        libsForQt5.breeze-icons  # For kwallet/dolphin

        # Games
        godot_4  # Godot engine
        sgt-puzzles  # Simon Tatham's puzzles
	      steam  # Steam
        vulkan-loader  # Steam runtime dependency?
     ];
  };

  programs.steam.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Shell
    fish  # Friendly Interactive Shell

    # Editor
    helix  # Helix editor

    # Coding
    git  # Git
    gh  # Github cli
    onefetch  # Git repo visualizer

    # Language
    ## Compilers & Interpreters
    gcc  # GCC
    llvmPackages_15.libclang  # Clang
    patchelf  # Patch binaries
    rustup  # Manage rust toolchains
    zig  # Zig toolchain
    ## LSP
    nil  # Nix LSP
    marksman  # Markdown LSP
    nodePackages.prettier  # Prettier
    rust-analyzer  # Rust LSP

    # Core utils
    bat  # Cat with wings
    bottom  # Modern top utility
    colordiff  # Diff- with color!
    delta  # Diffing tool (for git)
    direnv  # Manage environments based on directory (nix support)
    eza # Better ls (ll)
    ffmpeg_5-full  # Manage video
    file  # Get information on files
    gparted  # Disk management
    imagemagick  # Image commands like convert
    jq  # JSON tool
    kbd  # Keyboard & virtual terminal utils
    pandoc  # File conversion
    podman  # Better docker
    podman-compose  # Better docker-compose
    ripgrep  # Recursively search
    tealdeer  # tldr
    tmux  # Terminal multiplexer
    tmuxp  # tmux manager
    tree  # Display directory structure tree
    wget  # Network downloader
    zellij  # Terminal multiplexer
    zip  # Zipping
    unzip  # Unzipping
    p7zip  # 7z
    xdg-utils  # Application opening/desktop integration
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

  system.copySystemConfiguration = true;  # Copy this to /run/current-system/configuration.nix
  system.stateVersion = "23.11";  # nixos version
}

