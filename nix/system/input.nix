# Input and fonts

{ config, lib, pkgs, modulesPath, ... }:

{
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
    enable = true;
    type = "fcitx5";
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

  # console = {
  #   earlySetup = true;
  #   font = "${pkgs.hackgen-nf-font}/share/fonts/HackGen35ConsoleNF-Regular.ttf";
  #   keyMap = "us";
  # };

  environment.systemPackages = with pkgs; [
    font-manager
  ];
}
