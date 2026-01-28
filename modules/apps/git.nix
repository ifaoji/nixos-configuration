{ config, lib, pkgs, username, ... }:

let
  cfg = config.mySystem.git;
  _1passwordEnabled = config.mySystem._1password.enable;
in {
  options.mySystem.git = {
    enable = lib.mkEnableOption "GIT Configuration";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
    ];

    home-manager.users.${username} = { config, pkgs, lib, ... }: {
      programs.git = {
        enable = true;
        settings = {
          core = {
            editor = "hx";
          };
          gpg = {
            format = "ssh";
          };
          commit = {
            gpgsign = true;
          };
          "includeif \"gitdir:${config.xdg.configHome}/nixos-configuration/\"" = {
            path = "${config.xdg.configHome}/git/config-personal";
          };
          "includeIf \"gitdir:~/projects/work/\"" = {
            path = "${config.xdg.configHome}/git/config-work";
          };
          "includeif \"gitdir:~/projects/personal/\"" = {
            path = "${config.xdg.configHome}/git/config-personal";
          };
          "includeIf \"gitdir:~/projects/personal/student/\"" = {
            path = "${config.xdg.configHome}/git/config-personal-student";
          };
        }

        // lib.optionalAttrs _1passwordEnabled {
          "gpg \"ssh\"" = {
            program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
          };
        };
      };

      xdg.configFile."git/config-work".text = ''
        [user]
          name = Simon Dablander
          email = simon@42vienna.com
          signingKey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMv47HqQwwGNXfpgOElPYddMbD+S8iCS26jtzF3PUy6d
      '';

      xdg.configFile."git/config-personal".text = ''
        [user]
          name = Simon Dablander
          email = ifaoji@pm.me
          signingKey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMlG+0GA4HHzGj4047ZuJKSp5FjHWL8A9fx28G4tS0zC
      '';

      xdg.configFile."git/config-personal-student".text = ''
        [user]
          name = Simon Dablander
          email = sdabland@student.42vienna.com
          signingKey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMlG+0GA4HHzGj4047ZuJKSp5FjHWL8A9fx28G4tS0zC
      '';
    };
  };
}
