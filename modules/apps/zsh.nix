{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.zsh;
in {
  options.mySystem.zsh = {
    enable = lib.mkEnableOption "ZSH Configuration";
  };

  config = lib.mkIf cfg.enable {
    # TODO: also have terminal tools in here, or separate?
    environment.systemPackages = with pkgs; [
      bat
      eza
      htop
      inetutils
      oh-my-zsh
      unzip
      wget
      zoxide
      zsh
    ];

    users.defaultUserShell = pkgs.zsh;

    programs.zsh = {
      enable = true;

      shellAliases = {
        l = "eza -lah";
        la = "eza -la --icons --git";
        ll = "eza -l --icons --git";
        ls = "eza";
        lsa = "eza -lah";
        lt = "eza --tree --level=2 --icons";
      };

      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";

        plugins = [
          "docker"
          "zoxide"
        ]
          ++ lib.optionals config.mySystem.git.enable [ "git" ]
        ;
      };
    };
  };
}
