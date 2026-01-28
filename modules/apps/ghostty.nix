{ config, lib, pkgs, username, ... }:

let
  cfg = config.mySystem.ghostty;
in {
  options.mySystem.ghostty = {
    enable = lib.mkEnableOption "Ghostty Terminal";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ghostty
    ];

    home-manager.users.${username} = { config, pkgs, lib, ... }: {
      programs.ghostty = {
        enable = true;
        settings = {
          # This is the configuration file for Ghostty.
          #
          # This template file has been automatically created at the following
          # path since Ghostty couldn't find any existing config files on your system:
          #
          #   /home/${username}/.config/ghostty/config
          #
          # The template does not set any default options, since Ghostty ships
          # with sensible defaults for all options. Users should only need to set
          # options that they want to change from the default.
          #
          # Run `ghostty +show-config --default --docs` to view a list of
          # all available config options and their default values.
          #
          # Additionally, each config option is also explained in detail
          # on Ghostty's website, at https://ghostty.org/docs/config.

          # Config syntax crash course
          # ==========================
          # # The config file consists of simple key-value pairs,
          # # separated by equals signs.
          # font-family = Iosevka
          # window-padding-x = 2
          #
          # # Spacing around the equals sign does not matter.
          # # All of these are identical:
          # key=value
          # key= value
          # key =value
          # key = value
          #
          # # Any line beginning with a # is a comment. It's not possible to put
          # # a comment after a config option, since it would be interpreted as a
          # # part of the value. For example, this will have a value of "#123abc":
          # background = #123abc
          #
          # # Empty values are used to reset config keys to default.
          # key =
          #
          # # Some config options have unique syntaxes for their value,
          # # which is explained in the docs for that config option.
          # # Just for example:
          # resize-overlay-duration = 4s 200ms

          theme = "dark:Catppuccin Frappe,light:Catppuccin Latte";

          font-family = "Monaspace Radon Var";
          font-feature = [
            "ss01"
            "ss02"
            "ss03"
            "ss04"
            "ss05"
            "ss06"
            "ss07"
            "ss08"
            "ss09"
            "ss10"
            "liga"
            "calt"
          ];

          keybind = [
            "ctrl+t=new_tab"
            "ctrl+j=previous_tab"
            "ctrl+k=next_tab"
            "ctrl+q=close_tab"
            "ctrl+h=move_tab:-1"
            "ctrl+l=move_tab:1"
          ];
        };
      };
    };
  };
}
