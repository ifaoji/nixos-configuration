{ config, lib, pkgs, username, ... }:

let
  cfg = config.mySystem._1password;
in {
  options.mySystem._1password = {
    enable = lib.mkEnableOption "1Password Configuration";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      _1password-cli
      _1password-gui
    ];

    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      # Certain features, including CLI integration and system authentication support,
      # require enabling PolKit integration on some desktop environments (e.g. Plasma).
      polkitPolicyOwners = [ username ];
    };

    environment.etc = {
        "1password/custom_allowed_browsers" = {
          text = ''
            brave
            zen
          '';
          mode = "0755";
        };
    };
  };
}
