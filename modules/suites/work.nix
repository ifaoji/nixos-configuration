{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.suites.work;
in {
  options.mySystem.suites.work.enable = lib.mkEnableOption "Work Suite";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bitwarden-desktop
      remmina
      slack
    ];

    # TODO: add git stuff for work here?
    # home-manager.users.${username} = {
    #   programs.git.extraConfig = {
    #     "includeIf \"gitdir:~/projects/work/\"" = {
    #       path = "${config.xdg.configHome}/git/config-work";
    #     };
    #   };
      
    #   xdg.configFile."git/config-work".text = ''
    #     [user]
    #       name = Simon Dablander
    #       email = simon@42vienna.com
    #       signingKey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMv47HqQwwGNXfpgOElPYddMbD+S8iCS26jtzF3PUy6d
    #   '';
    # };

    programs.zsh.shellAliases = {
      vpn-connect = "sudo systemctl start openvpn-work.service";
      vpn-uconnect= "sudo systemctl stop openvpn-work.service";
    };
  };
}
