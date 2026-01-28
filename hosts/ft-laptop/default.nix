{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    # Add core for globally shared settings instead of configuration.nix import in flake?
    # ../../modules/core
  ];

  # TODO: ??
  # networking.hostName = "ft-laptop";

  mySystem.openvpn.enable = true;
  mySystem.suites.work.enable = true;

  # Some weird DNS problems happen when switching from corporate wifi...
  # Don't ask why :P
  networking.networkmanager.dns = "systemd-resolved";
  services.resolved.enable = true;
  networking.nameservers = [ "9.9.9.9" "149.112.112.112" ];
}
