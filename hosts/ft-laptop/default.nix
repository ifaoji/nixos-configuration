{ inputs, pkgs, username, ... }:

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

  environment.systemPackages = [
    inputs.hayase-flake.packages.${pkgs.stdenv.hostPlatform.system}.default

    (pkgs.writeShellScriptBin "reload-trackpad" ''
      #! /usr/bin/env bash
      rmmod i2c_hid_acpi && modprobe i2c_hid_acpi
    '')
  ];


  security.sudo.extraRules = [{
    users = [ username ];
    commands = [{
      command = "/run/current-system/sw/bin/reload-trackpad";
      options = [ "NOPASSWD" ];
    }];
  }];
}
