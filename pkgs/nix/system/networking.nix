# Networking settings

{ config, lib, pkgs, modulesPath, user, ... }:

{
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;  # nmapplet
  # services.gnome.gnome-keyring.enable = true;  # Remember passwords
  # security.pam.services.greetd.enableGnomeKeyring = true;  # Unlock keyring on login (for greetd)
  networking.wireguard.enable = true;
  
  # programs.openssh.startAgent = true;
  services.pcscd.enable = true;
  programs.ssh.agentPKCS11Whitelist = "${pkgs.opensc}/lib/opensc-pkcs11.so";
  environment.etc."pkcs11/modules/opensc-pkcs11".text = ''
    module: ${pkgs.opensc}/lib/opensc-pkcs11.so
  '';
  programs.firefox.policies.SecurityDevices.p11-kit-proxy = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users.${user} = {
   extraGroups = [ "network" "networkmanager" ];
  };

  # programs.ssh.startAgent = true;  # Not with gnome-keyring
  # services.openssh = {
  #   enable = true;
  #   # require public key authentication for better security
  #   settings.PasswordAuthentication = false;
  #   settings.KbdInteractiveAuthentication = false;
  #   #settings.PermitRootLogin = "yes";
  # };

  services.udev.packages = [ pkgs.yubikey-personalization ];

  environment.systemPackages = [
    pkgs.opensc
    pkgs.p11-kit
    pkgs.libfido2
    pkgs.yubikey-manager
  ];
}
