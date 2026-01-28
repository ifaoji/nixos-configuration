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
}
