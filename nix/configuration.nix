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
        '';
  };

in
{
  imports =
    [ 
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  hardware.opengl.driSupport32Bit = true;  # steam?

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["mem_sleep_default=deep"];
  boot.loader.grub.device = "/dev/sda";
  boot.supportedFilesystems = [ "ntfs" ];

  services.fprintd.enable = true;

  networking.hostName = "hachha-laptop-nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

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
  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-mozc
  #     fcitx5-gtk
  #   ];
  # };
  fonts.fonts = with pkgs; [
    #(nerdfonts.override { fonts = [ "" ]; })
    powerline-fonts
    #nerdfonts
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
      glib # gsettings
      grim # screenshot functionality
      bemenu # wayland clone of dmenu
      wdisplays # tool to configure displays
      dbus-sway-environment  # DBUS environment (custom)
      configure-gtk  # GTK configuration (custom)
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
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };
  security.polkit.enable = true;
  hardware.opengl.enable = true;
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

  # VT color
  # systemd.services.vt_color = {
  #   enable = true;
  #   description = "Virtual terminal color";
  #   unitConfig = {
  #     Type = "oneshot";
  #   };
  #   serviceConfig = {
  #     ExecStart = "/home/${user}/.config/configw/scripts/vt_nord.sh";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };
  
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

  # Define user
  users.users.${user} = {
     isNormalUser = true;
     extraGroups = [ "docker" "video" "wheel" ];
     initialPassword =  "password";
     shell = pkgs.fish;
     packages = with pkgs; [
        # Essential
        firefox-wayland
      	alacritty
 	      discord
	      steam

        # Fonts
        font-manager
        
	      # CLI+
        ## Editor
        vscode
        ## Other
        tealdeer  # better manpages/tldr
        hoard  # manage cli commands
        tokei  # Code counter

        # Utils
        calibre  # ebook software
        (callPackage ./pkgs/cdtest.nix { })  # Manage temporary project directories
        feh  # View images
        vlc  # Audio-video viewerw
        obs-studio  # Capture audio and video        
        xplorer  # File explorer
        zathura  # PDF viewier

        # Fun
        sgtpuzzles

        # Class
        # teams
        anki-bin

        # Icons
        gnome.adwaita-icon-theme  # Used for firefox

        # Games
        vulkan-loader
     ];
  };

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
    gcc
    llvmPackages_15.libclang
    patchelf  # Patch binaries
    python3
    rustup
    zig
    ## LSP
    nil  # Nix LSP
    marksman  # Markdown LSP
    rust-analyzer  # Rust LSP

    # Core utils
    bat  # Cat with wings
    bottom  # Top utility written in rust
    colordiff  # Diff- with color!
    delta  # Diffing tool
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
      pandas
      pip
      "python-lsp-server[all]"
      requests
    ]))
  ];

  system.copySystemConfiguration = true;  # Copy this to /run/current-system/configuration.nix
  system.stateVersion = "23.05";  # nixos version
}

