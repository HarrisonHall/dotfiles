# configuration.nix
## Nix configuration - Harrison Hall
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
        gsettings set $gnome_schema gtk-theme 'Dracula'
        gsettings set org.gnome.desktop.interface cursor-theme "capitaine-cursors"
        '';
  };

in
{
  imports =
    [ 
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
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
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
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
    powerline-fonts
    hackgen-nf-font
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "HackGen35 Console NF"
      "IPAGothic"
    ];
    sansSerif = [
      "Noto Sans"
      "IPAPGothic"
    ];
    serif = [
      "Noto Serif"
      "IPAPMincho"
    ];
  };

  # Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      wayland  # Wayland libs
      wayland-protocols  # Other wayland stuffs
      glib # gsettings
      bemenu # Wayland clone of dmenu
      wdisplays # tool to configure displays
      dbus-sway-environment  # DBUS environment (custom)
      configure-gtk  # GTK configuration (custom)
      swayr  # Simple cli for managing sway
      swaylock  # Lock screen management
      swayidle  # Idle management
      wl-clipboard  # Wayland clipboard utilities
      wf-recorder  # Wayland screen recorder
      mako  # Wayland notification daemon
      grim  # Screenshot tool
      slurp  # Screenspace selector
      waybar  # Better swaybar
      wofi  # Wayland rofi
      swaybg  # Change sway bg
      capitaine-cursors  # Cursor
      mate.mate-polkit  # Polkit
      networkmanagerapplet  # Network manager bar applet

      mesa
      glfw
      glfw-wayland
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
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
  services.xserver.enable = true;

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
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
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

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  environment.variables.EDITOR = "hx";
  environment.variables.VISUAL = "code";

  # Enable automounting
  services.udisks2.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

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
        # (callPackage ./pkgs/cdtest.nix { })  # Manage temporary project directories
        du-dust  # Disk-usage command
        hoard  # manage cli commands
        mdp  # Markdown presentation tool
        tealdeer  # better manpages/tldr
        tokei  # Code counter
        #obsidian  # Obsidian

        # Utils
        calibre  # ebook software
        dolphin  # File explorer
        feh  # View images
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

        # Class
        anki-bin

        # Icons
        gnome.adwaita-icon-theme  # Used for firefox
        libsForQt5.breeze-icons  # For kwallet/dolphin

        # Games
        godot_4
        sgt-puzzles
	      steam
        vulkan-loader
     ];
  };

  programs.steam.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Shell
    fish

    # Editor
    helix

    # Coding
    git
    gh
    onefetch

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
    rust-analyzer  # Rust LSP

    # Core utils
    bat  # Cat with wings
    bottom  # Modern top utility
    colordiff  # Diff- with color!
    delta  # Diffing tool (for git)
    eza # Better ls (ll)
    ffmpeg_5-full  # Manage video
    file  # Get information on files
    gparted  # Disk management
    imagemagick  # Image commands like convert
    kbd  # Keyboard & virtual terminal utils
    pandoc  # File conversion
    ripgrep  # Recursively search
    tealdeer  # tldr
    tmux  # Terminal multiplexer
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

