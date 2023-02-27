# configuration.nix
## Nix configuration - Harrison Hall
## Check `man configuration.nix` or nixos manual (`nixos-help`)

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.opengl.driSupport32Bit = true;  # steam?

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["mem_sleep_default=deep"];
  boot.loader.grub.device = "/dev/sda"; # TODO - can this be generalized?

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

  # Enable Wayland and X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };
  
  # Enable sound.
  sound.enable = true;
  security.rtkit.enable = true;  # Recommended for pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.harrison = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     initialPassword =  "password";
     shell = pkgs.fish;
     packages = with pkgs; [
        # Essential
        firefox-wayland
      	alacritty
	      hackgen-nf-font
	      discord
	      steam
	
        # CLI
        ## Editor
        lapce
        ## Other
        tealdeer  # better manpages/tldr
        hoard  # manage cli commands
        tokei  # Code counter

        # Utils
        flameshot  # Take screenshots
        feh  # View images
        vlc  # Audio-video viewerw
        obs-studio  # Capture audio and video        
        zathura  # PDF viewier

        # Fun
        sgtpuzzles

        # Class
        # teams

        # 
        gnome.adwaita-icon-theme  # Used for firefox
     ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Shell
    fish
    starship

    # Editor
    helix

    # Coding
    git
    gh
    onefetch

    # Language & Building
    gcc
    llvmPackages_15.libclang
    python3
    rustup
    rust-analyzer
    zig

    # Core utils
    bat
    bottom
    colordiff
    ffmpeg_5-full
    file
    tree
    wget  # Network downloader
    zip  # Zipping
    unzip  # Unzipping
    p7zip  # 7z
    tealdeer
    ripgrep
    zellij  # Terminal multiplixer
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.copySystemConfiguration = true;  # Copy this to /run/current-system/configuration.nix

  system.stateVersion = "22.11"; # https://nixos.org/nixos.options.html read docs for ugprading
}

