{ lib, pkgs, ... }:

let

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
        gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-macchiato-dark"
        gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Catppuccin"
        gsettings set org.gnome.desktop.interface cursor-size "24"
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
        gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
        '';
  };

in
{
  programs.sway = {
    enable = true;
    wrapperFeatures.base = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      # Custom configuration
      configure-gtk  # GTK configuration (custom)
      dbus-sway-environment  # DBUS environment (custom)

      # Icon configuration
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
      swayr  # Simple cli for managing sway

      # Graphical Utils
      pavucontrol  # Audio control
      rofi # Widgets and pickers
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
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.variables.XCURSOR_PATH = lib.mkDefault "$HOME/.icons:$HOME/.local/share/icons:$HOME/.nix-profile/share/icons:/usr/share/icons"; # "~/.nix-profile/bin/<your app>";
}
