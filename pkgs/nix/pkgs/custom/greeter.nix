# Greeter configuration

{ lib, pkgs, ... }:

{
  # greetd-tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
        # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
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
}
