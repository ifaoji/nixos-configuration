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

    programs.zsh.enable = true;
    programs.zsh.ohMyZsh = {
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
}
