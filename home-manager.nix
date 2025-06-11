let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in
{
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  users.users.phi.isNormalUser = true;
  home-manager.users.phi = { pkgs, lib, ... }: {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };

    programs.home-manager.enable = true;
    home.file."hello.txt".text = "Hello from Home Manager!";

    home.packages = [
      pkgs.atool
      pkgs.httpie
      pkgs._1password-gui
      pkgs.git
      pkgs.gnomeExtensions.clipboard-history
      pkgs.gnomeExtensions.dash-to-dock
    ];

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.11";

    dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = [];
        switch-windows = ["<Alt>Tab"];
        switch-windows-backward = ["<Shift><Alt>Tab"];
      };
      "org/gnome/shell/app-switcher" = {
        current-workspace-only = false;
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":minimize,maximize,close";
        group-windows = false;
      };
      "org/gnome/shell" = {
        enabled-extensions = [
          "clipboard-history@alexsaveau.dev"
          "dash-to-dock@micxgx.gmail.com"
        ];
      };
      "org/gnome/shell/extensions/clipboard-history" = {
        "cache-only-favorites"=false;
        "strip-text"=true;
        "toggle-menu"=[ "<Super>v" ];
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        "always-center-icons"=true;
        "application-counter-overrides-notifications"=true;
        "apply-custom-theme"=false;
        "autohide-in-fullscreen"=false;
        "background-color"="rgb(0,0,0)";
        "background-opacity"=1.0;
        "click-action"="minimize-or-previews";
        "custom-background-color"=true;
        "custom-theme-shrink"=true;
        "customize-alphas"=true;
        "dash-max-icon-size"=30;
        "disable-overview-on-startup"=false;
        "dock-fixed"=false;
        "dock-position"="BOTTOM";
        "extend-height"=true;
        "height-fraction"=0.90000000000000002;
        "hide-tooltip"=false;
        "hot-keys"=false;
        "icon-size-fixed"=false;
        "intellihide"=true;
        "intellihide-mode"="ALL_WINDOWS";
        "isolate-monitors"=false;
        "isolate-workspaces"=false;
        "max-alpha"=0.80000000000000004;
        "middle-click-action"="launch";
        "multi-monitor"=true;
        "preferred-monitor"=-2;
        "preferred-monitor-by-connector"="eDP-1";
        "preview-size-scale"=0.0;
        "running-indicator-dominant-color"=true;
        "running-indicator-style"="DASHES";
        "shift-click-action"="minimize";
        "shift-middle-click-action"="launch";
        "show-apps-always-in-the-edge"=false;
        "show-apps-at-top"=true;
        "show-icons-emblems"=true;
        "show-icons-notifications-counter"=true;
        "show-mounts-network"=true;
        "show-running"=true;
        "show-show-apps-button"=true;
        "show-trash"=false;
        "transparency-mode"="FIXED";
        "unity-backlit-items"=false;
      };
    };

    programs.ghostty = {
      enable = true;
      settings = {
                # This is the configuration file for Ghostty.
        #
        # This template file has been automatically created at the following
        # path since Ghostty couldn't find any existing config files on your system:
        #
        #   /home/phi/.config/ghostty/config
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

        theme = "dark:catppuccin-frappe,light:catppuccin-latte";

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

    programs.git = {
      enable = true;
      extraConfig = {
        core = {
          editor = "hx";
        };
        user = {
          name = "Simon Dablander";
          email = "simon@42vienna.com";
          signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMv47HqQwwGNXfpgOElPYddMbD+S8iCS26jtzF3PUy6d";
        };
        gpg = {
          format = "ssh";
        };
        "gpg \"ssh\"" = {
          program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        };
        commit = {
          gpgsign = true;
        };
      };
    };

    programs.helix = {
      enable = true;

      settings = {
        theme = "catppuccin_latte";

        editor = {
          true-color = true;
          line-number = "relative";
          rulers = [ 80 ];
          bufferline = "multiple";
        };

        editor.cursor-shape = {
          normal  = "block";
          insert  = "bar";
          select  = "underline";
          
        };

        editor.indent-guides = {
          character = "╎";
          render = true;
        };

        editor.lsp = {
          display-inlay-hints = false;
          auto-signature-help = false;
        };

        editor.smart-tab = {
          enable = false;
        };

        editor.file-picker = {
          hidden = false;
        };

        editor.whitespace = {
          render = "none";
          characters = {
            space = "·";
            nbsp = "⍽";
            tab = "→";
            newline = "⏎";
            tabpad = "·"; # Tabs will look like "→···" (depending on tab width)
          };
        };

        keys.normal = {
          A-x = "extend_to_line_bounds";
          X = [ "extend_line_up" "extend_to_line_bounds" ];
        };

        keys.select = {
          A-x = "extend_to_line_bounds";
          X = [ "extend_line_up" "extend_to_line_bounds" ];
        };
      };

      languages = {
        language-server.emmet-lsp = {
          command = "${pkgs.emmet-ls}/bin/emmet-ls";
          args = [ "--stdio" ];
        };

        language-server.pyright = {
          command = "${pkgs.pyright}/bin/pyright-langserver";
          args = [ "--stdio" ];
        };

        language-server.rust-analyzer.config.check = {
          command = "clippy";
        };

        language-server.svelte-lsp = {
          command = "${pkgs.svelte-language-server}/bin/svelteserver";
          args = [ "--stdio" ];
        };

        language-server.tailwindcss-lsp = {
          command = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
          args = [ "--stdio" ];
        };

        language-server.typescript-lsp = {
          command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
          args = [ "--stdio" ];
        };

        language = [
          {
            name = "c";
            file-types = [ "c" "h" ];
            indent = {
              tab-width = 4;
              unit = "t";
            };
          }

          {
            name = "cpp";
            file-types = [ "cpp" "hpp" ];
            auto-format = true;
          }

          {
            name = "css";
            language-servers = [ "vscode-css-language-server" "tailwindcss-ls" ];
          }

          {
            name = "go";
            auto-format = true;
            formatter = {
              command = "goimports";
            };
          }

          {
            name = "html";
            language-servers = [ "vscode-html-language-server" "tailwindcss-lsp" "emmet-lsp" ];
          }

          {
            name = "javascript";
            language-servers = [ "typescript-lsp" ];
          }

          {
            name = "jsx";
            language-servers = [ "typescript-lsp" "tailwindcss-lsp" "emmet-lsp" ];
          }

          {
            name = "python";
            formatter = {
              command = "black";
              args = [ "--quiet" "-" ];
            };
            auto-format = true;
            roots = ["pyproject.toml"];
            language-servers = [ "pyright" ];
          }

          {
            name = "svelte";
            language-servers = [ "svelte-lsp" "tailwindcss-lsp" "emmet-lsp" ];
          }

          {
            name = "tsx";
            language-servers = [ "typescript-lsp" "tailwindcss-lsp" "emmet-lsp" ];
          }

          {
            name = "typescript";
            language-servers = [ "typescript-lsp" ];
          }
        ];
      };
    };
  };
}
