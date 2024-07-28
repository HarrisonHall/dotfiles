# Sound configuration

{ config, lib, pkgs, modulesPath, ... }:

{
  # sound.enable = true;
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
}
