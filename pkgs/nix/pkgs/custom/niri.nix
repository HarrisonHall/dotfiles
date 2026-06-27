{ lib, pkgs, user, ... }:

{
  programs.niri = {
    enable = true;
  };

  users.users.${user}.packages = with pkgs; [
    # Necessary for niri.
    unstable.xwayland-satellite

    # Icon configuration
    papirus-icon-theme  # Icons

    # Libs
    glib # gsettings
    glfw
    libnotify  # libnotify + notify-send
    mesa
    wayland  # Wayland libs
    wayland-protocols  # Other wayland stuffs

    # Essential
    unstable.ashell  # Core bar
    # mako  # Wayland notification daemon
    mate-polkit  # Polkit
    networkmanagerapplet  # Network manager bar applet
    shared-mime-info  # Allow apps to have mime info
    swaylock  # Lock screen management
    swayidle  # Idle management
    waybar  # Better swaybar
    wev  # Wayland keyboard
    wl-clipboard  # Wayland clipboard utilities
    wtype  # Wayland type utility
    wf-recorder  # Wayland screen recorder
    xdg-user-dirs  # XDG help
    xdg-utils  # XDG

    # Scripting Utils
    acpi  # Battery
    slurp  # Screenspace selector
    swaybg  # Change sway bg

    # Graphical Utils
    pavucontrol  # Audio control
    rofi # Widgets and pickers
    rofi-emoji  # Emoji picker
    wdisplays # Configure displays
  ];
  
  # Security
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

  # Enable dbus
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-cosmic ];
  };

  environment.variables.XCURSOR_PATH = lib.mkDefault "$HOME/.icons:$HOME/.local/share/icons:$HOME/.nix-profile/share/icons:/usr/share/icons"; # "~/.nix-profile/bin/<your app>";

  systemd.user.services."niri-swaybg" = {
    enable = true;
    serviceConfig.ExecStart = "${pkgs.swaybg}/bin/swaybg -i /home/${user}/media/wallpapers/current.image";
    wantedBy = ["niri.service"];
    after = [ "graphical-session.target" ];
    serviceConfig.Restart = "on-failure";
  };
  systemd.user.services."niri-network-manager" = {
    enable = true;
    serviceConfig.ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
    wantedBy = ["niri.service"];
    after = [ "graphical-session.target" ];
    serviceConfig.Restart = "on-failure";
  };
  systemd.user.services."waybar" = {
    enable = false;
    serviceConfig.ExecStart = "${pkgs.waybar}/bin/waybar";
    wantedBy = ["niri.service"];
    after = [ "graphical-session.target" ];
    serviceConfig.Restart = "on-failure";
    environment = lib.mkForce {};
    conflicts = ["ashell.service"];
  };
  systemd.user.services."ashell" = {
    enable = true;
    serviceConfig.ExecStart = "${pkgs.unstable.ashell}/bin/ashell";
    wantedBy = ["niri.service"];
    after = [ "graphical-session.target" ];
    serviceConfig.Restart = "on-failure";
    environment = lib.mkForce {};
  };
  systemd.user.services."mako" = {
    enable = false;
    serviceConfig.ExecStart = "${pkgs.mako}/bin/mako";
    wantedBy = ["niri.service"];
    after = [ "graphical-session.target" ];
    serviceConfig.Restart = "on-failure";
  };
  systemd.user.services."niri-fcitx" = {
    enable = true;
    serviceConfig.ExecStart = "${pkgs.fcitx5}/bin/fcitx5";
    wantedBy = ["niri.service"];
    after = [ "graphical-session.target" ];
    serviceConfig.Restart = "on-failure";
  };
  systemd.user.services."niri-polkit" = {
    enable = true;
    serviceConfig.ExecStart = "sh -c \"/nix/store/$(ls -la /nix/store | grep 'mate-polkit' | grep '4096' | awk '{print $9}' | sed -n '$p')/libexec/polkit-mate-authentication-agent-1\"";
    wantedBy = ["niri.service"];
    after = [ "graphical-session.target" ];
    serviceConfig.Restart = "on-failure";
  };
  systemd.user.services."niri-swayidle" = {
    enable = true;
    serviceConfig.ExecStart = ''
      ${pkgs.swayidle}/bin/swayidle -w \
        timeout 500 'swaylock -f' \
        timeout 600 'niri msg action power-off-monitors' \
        before-sleep 'swaylock -f'
    '';
    wantedBy = ["niri.service"];
    after = [ "graphical-session.target" ];
    serviceConfig.Restart = "on-failure";
  };
}
