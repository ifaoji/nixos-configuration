{ config, lib, pkgs, username, ... }:

let
  cfg = config.mySystem.openvpn;
in {
  options.mySystem.openvpn = {
    enable = lib.mkEnableOption "OpenVPN Configuration";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      openvpn
    ];

    services.openvpn.servers = {
      work = {
        config = ''
          script-security 2
          up ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
          up-restart
          down ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
          down-pre
          config /home/${username}/projects/work/openvpn/work.conf
        '';
        autoStart = false;
        updateResolvConf = false;
      };
    };
  };
}
