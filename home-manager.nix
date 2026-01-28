{ username, inputs, ... }:
{
  imports = [
    inputs.home-manager-flake.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  users.users.${username}.isNormalUser = true;
  home-manager.users.${username} = { config, pkgs, lib, ... }: {
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
      pkgs.gnomeExtensions.blur-my-shell
      pkgs.gnomeExtensions.clipboard-history
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.rounded-window-corners-reborn
      pkgs.gnomeExtensions.tiling-shell
      pkgs.gnomeExtensions.transparent-window-moving
      pkgs.gnomeExtensions.unblank
    ];

    home.pointerCursor = {
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
      size = 24;
    };

    gtk = {
      enable = true;
      cursorTheme = {
        name = "breeze_cursors";
        package = pkgs.kdePackages.breeze;
        size = 24;
      };
    };

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.11";

    dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        # Navigation
        move-to-workspace-1 = ["<Shift><Alt>1"];
        move-to-workspace-2 = ["<Shift><Alt>2"];
        move-to-workspace-3 = ["<Shift><Alt>3"];
        move-to-workspace-4 = ["<Shift><Alt>4"];
        move-to-workspace-left = ["<Shift><Alt>j"];
        move-to-workspace-right = ["<Shift><Alt>k"];
        switch-to-workspace-1 = ["<Alt>1"];
        switch-to-workspace-2 = ["<Alt>2"];
        switch-to-workspace-3 = ["<Alt>3"];
        switch-to-workspace-4 = ["<Alt>4"];
        switch-to-workspace-left = ["<Alt>h"];
        switch-to-workspace-right = ["<Alt>l"];

        # Windows
        close = ["<Alt>q"];
        toggle-maximized = ["<Alt>m"];
        switch-applications = [];
        switch-windows = ["<Alt>Tab"];
        switch-windows-backward = ["<Shift><Alt>Tab"];
      };
      "org/gnome/shell/keybindings" = {
        show-screenshot-ui = ["<Shift><Alt>s"];
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
          "blur-my-shell@aunetx"
          "clipboard-history@alexsaveau.dev"
          "dash-to-dock@micxgx.gmail.com"
          "rounded-window-corners@fxgn"
          "tilingshell@ferrarodomenico.com"
          "transparent-window-moving@noobsai.github.com"
          "unblank@sun.wxg@gmail.com"
        ];
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        pipelines = "pipelines={'pipeline_default': {'name': <'Default'>, 'effects': <[<{'type': <'native_static_gaussian_blur'>, 'id': <'effect_000000000000'>, 'params': <{'radius': <30>, 'brightness': <0.59999999999999998>}>}>]>}, 'pipeline_default_rounded': {'name': <'Default rounded'>, 'effects': <[<{'type': <'native_static_gaussian_blur'>, 'id': <'effect_61478604095462'>, 'params': <{'radius': <30>, 'brightness': <0.59999999999999998>}>}>, <{'type': <'corner'>, 'id': <'effect_99011191584976'>, 'params': <{'radius': <24>}>}>]>}, 'pipeline_45077595068140': {'name': <'Dock'>, 'effects': <[<{'type': <'corner'>, 'id': <'effect_35950350830793'>, 'params': <{'radius': <48>, 'corners_bottom': <true>, 'corners_top': <false>}>}>]>}}";
        "settings-version" = 2;

        "appfolder/brightness" = 0.59999999999999998;
        "appfolder/sigma" = 30;

        "applications/blur" = false;
        "applications/blur-on-overview" = false;
        "applications/dynamic-opacity" = true;

        "coverflow-alt-tab/pipeline" = "pipeline_default";

        "dash-to-dock/blur" = false;
        "dash-to-dock/brightness" = 1.0;
        "dash-to-dock/override-background" = false;
        "dash-to-dock/pipeline" = "pipeline_45077595068140";
        "dash-to-dock/sigma" = 0;
        "dash-to-dock/static-blur" = true;
        "dash-to-dock/style-dash-to-dock" = 2;
        "dash-to-dock/unblur-in-overview" = false;

        "hidetopbar/compatibility" = false;

        "lockscreen/pipeline" = "pipeline_default";

        "overview/pipeline" = "pipeline_default";

        "panel/blur" = false;
        "panel/brightness" = 0.59999999999999998;
        "panel/force-light-text" = true;
        "panel/pipeline" = "pipeline_default";
        "panel/sigma" = 8;
        "panel/static-blur" = false;

        "screenshot/pipeline" = "pipeline_default";

        "window-list/brightness" = 0.59999999999999998;
        "window-listsigma" = 30;
      };

      "org/gnome/shell/extensions/clipboard-history" = {
        "cache-only-favorites"=false;
        "strip-text"=true;
        "toggle-menu"=[ "<Super>v" ];
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        "always-center-icons" = true;
        "application-counter-overrides-notifications" = true;
        "apply-custom-theme" = false;
        "autohide-in-fullscreen" = false;
        "background-color" = "rgb(0,0,0)";
        "background-opacity" = 1.0;
        "click-action" = "minimize-or-previews";
        "custom-background-color" = true;
        "custom-theme-shrink" = true;
        "customize-alphas" = true;
        "dash-max-icon-size" = 30;
        "disable-overview-on-startup" = false;
        "dock-fixed" = false;
        "dock-position" = "BOTTOM";
        "extend-height" = true;
        "height-fraction" = 0.90000000000000002;
        "hide-tooltip" = false;
        "hot-keys" = false;
        "icon-size-fixed" = false;
        "intellihide" = true;
        "intellihide-mode" = "ALL_WINDOWS";
        "isolate-monitors" = false;
        "isolate-workspaces" = false;
        "max-alpha" = 0.80000000000000004;
        "middle-click-action" = "launch";
        "multi-monitor" = true;
        "preferred-monitor" = -2;
        "preferred-monitor-by-connector" = "eDP-1";
        "preview-size-scale" = 0.0;
        "running-indicator-dominant-color" = true;
        "running-indicator-style" = "DASHES";
        "shift-click-action" = "minimize";
        "shift-middle-click-action" = "launch";
        "show-apps-always-in-the-edge" = false;
        "show-apps-at-top" = true;
        "show-icons-emblems" = true;
        "show-icons-notifications-counter" = true;
        "show-mounts-network" = true;
        "show-running" = true;
        "show-show-apps-button" = true;
        "show-trash" = false;
        "transparency-mode" = "FIXED";
        "unity-backlit-items" = false;
      };

      "org/gnome/shell/extensions/rounded-window-corners-reborn" = {
        "settings-version" = "uint32 7";
      };

      "org/gnome/shell/extensions/tiling-shell" = {
        "active-screen-edges" = true;
        "inner-gaps" = "uint32 4";
        "last-version-name-installed" = "16.4";
        "layouts-json" = "[{'id':'Layout 1','tiles':[{'x':0,'y':0,'width':0.22,'height':0.5,'groups':[1,2]},{'x':0,'y':0.5,'width':0.22,'height':0.5,'groups':[1,2]},{'x':0.22,'y':0,'width':0.56,'height':1,'groups':[2,3]},{'x':0.78,'y':0,'width':0.22,'height':0.5,'groups':[3,4]},{'x':0.78,'y':0.5,'width':0.22,'height':0.5,'groups':[3,4]}]},{'id':'Layout 2','tiles':[{'x':0,'y':0,'width':0.22,'height':1,'groups':[1]},{'x':0.22,'y':0,'width':0.56,'height':1,'groups':[1,2]},{'x':0.78,'y':0,'width':0.22,'height':1,'groups':[2]}]},{'id':'Layout 3','tiles':[{'x':0,'y':0,'width':0.33,'height':1,'groups':[1]},{'x':0.33,'y':0,'width':0.67,'height':1,'groups':[1]}]},{'id':'Layout 4','tiles':[{'x':0,'y':0,'width':0.67,'height':1,'groups':[1]},{'x':0.67,'y':0,'width':0.33,'height':1,'groups':[1]}]}]";
        "outer-gaps" = "uint32 4";
        "overridden-settings" = "{\"org.gnome.mutter.keybindings\":{\"toggle-tiled-right\":\"['<Super>Right']\",\"toggle-tiled-left\":\"['<Super>Left']\"},\"org.gnome.desktop.wm.keybindings\":{\"maximize\":\"['<Super>Up']\",\"unmaximize\":\"['<Super>Down', '<Alt>F5']\"},\"org.gnome.mutter\":{\"edge-tiling\":\"true\"}}";
        "override-window-menu" = true;
        "resize-complementing-windows" = true;
        "restore-window-original-size" = true;
        "selected-layouts" = ["['Layout 2']" "['Layout 2']"];
        "show-indicator" = true;
        "snap-assistant-threshold" = "uint32 54";
        "top-edge-maximize" = false;
      };

      "org/gnome/shell/extensions/transparent-window-moving" = {
        "window-opacity" = 240;
      };

      "org/gnome/shell/extensions/unblank" = {
        "time" = 0;
      };
    };

    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        # { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      ];
      commandLineArgs = [
        # "--disable-features=WebRtcAllowInputVolumeAdjustment"
        "--enable-features=TouchpadOverscrollHistoryNavigation,UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    };
  };
}
