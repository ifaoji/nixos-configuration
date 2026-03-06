{ username, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # Add core for globally shared settings instead of configuration.nix import in flake?
    # ../../modules/core
  ];

  networking.hostName = "onigiri-desktop";

  mySystem.openvpn.enable = true;
  mySystem.suites.work.enable = true;

  # Some weird DNS problems happen when switching from corporate wifi...
  # Don't ask why :P
  networking.networkmanager.dns = "systemd-resolved";
  services.resolved.enable = true;
  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
  ];

  environment.systemPackages = with pkgs; [
    satty
  ];

  # home-manager.users.${username} =
  #   {
  #     config,
  #     pkgs,
  #     lib,
  #     ...
  #   }:
  #   {
  #     services.flameshot = {
  #       # Also installs/enables flameshot
  #       enable = true;
  #       settings = {
  #         General = {
  #           useGrimAdapter = true;
  #           # Stops warnings for using Grim
  #           disabledGrimWarning = true;
  #         };
  #       };
  #     };
  #   };
}
