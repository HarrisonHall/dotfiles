# Greeter configuration

{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tuigreet
  ];
  # greetd-tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        # command = "${pkgs.tuigreet}/bin/tuigreet --time";
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
