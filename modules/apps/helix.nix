{ config, lib, pkgs, username, ... }:

let
  cfg = config.mySystem.helix;
in {
  options.mySystem.helix = {
    enable = lib.mkEnableOption "Helix Configuration";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      helix
    ];

    home-manager.users.${username} = { config, pkgs, lib, ... }: {
      programs.helix = {
        enable = true;

        settings = {
          # theme = "catppuccin_latte";
          theme = "tokyonight_moon";

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
          language-server.c-lsp = {
            command = "${pkgs.clang-tools}/bin/clangd";
          };

          language-server.emmet-lsp = {
            command = "${pkgs.emmet-ls}/bin/emmet-ls";
            args = [ "--stdio" ];
          };

          language-server.go-lsp = {
            command = "${pkgs.gopls}/bin/gopls";
            args = [ "-logfile=/tmp/gopls.log" "serve" ];
          };


          language-server.golangci-lint-langserver = {
            command = "${pkgs.golangci-lint-langserver}/bin/golangci-lint-langserver";
            args = [ "run" "--output.json.path" "stdout" "--show-stats=false" "--issues-exit-code=1" ];
            config = {
              command = [ "${pkgs.golangci-lint}/bin/golangci-lint" "run" "--output.json.path=stdout" "--show-stats=false" "--issues-exit-code=1" ];
            };
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
              language-servers = [ "c-lsp" ];
              file-types = [ "c" "h" ];
              indent = {
                tab-width = 4;
                unit = "t";
              };
              formatter = {
                command = "${pkgs.clang-tools}/bin/clang-format";
                args = [ "-style=file" "-fallback-style=LLVM" ];
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
              formatter = {
                command = "${pkgs.prettierd}/bin/prettierd";
                args = [".css"];
              };
            }

            {
              name = "go";
              language-servers = [ "go-lsp" "golangci-lint-langserver" ];
              auto-format = true;
              formatter = {
                command = "${pkgs.gotools}/bin/goimports";
              };
            }

            {
              name = "html";
              language-servers = [ "vscode-html-language-server" "tailwindcss-lsp" "emmet-lsp" ];
              formatter = {
                command = "${pkgs.prettierd}/bin/prettierd";
                args = [".html"];
              };
            }

            {
              name = "javascript";
              language-servers = [ "typescript-lsp" ];
              formatter = {
                command = "${pkgs.prettierd}/bin/prettierd";
                args = [".js"];
              };
            }

            {
              name = "json";
              formatter = {
                command = "${pkgs.prettierd}/bin/prettierd";
                args = [".json"];
              };
            }

            {
              name = "jsx";
              language-servers = [ "typescript-lsp" "tailwindcss-lsp" "emmet-lsp" ];
              formatter = {
                command = "${pkgs.prettierd}/bin/prettierd";
                args = [".jsx"];
              };
            }

            {
              name = "markdown";
              formatter = {
                command = "${pkgs.prettierd}/bin/prettierd";
                args = [".md"];
              };
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
              formatter = {
                command = "${pkgs.prettierd}/bin/prettierd";
                args = [".svelte"];
              };
            }

            {
              name = "tsx";
              language-servers = [ "typescript-lsp" "tailwindcss-lsp" "emmet-lsp" ];
              formatter = {
                command = "${pkgs.prettierd}/bin/prettierd";
                args = [".tsx"];
              };
            }

            {
              name = "typescript";
              language-servers = [ "typescript-lsp" ];
              formatter = {
                command = "${pkgs.prettierd}/bin/prettierd";
                args = [".ts"];
              };
            }

            {
              name = "yaml";
              formatter = {
                command = "${pkgs.prettierd}/bin/prettierd";
                args = [".md"];
              };
            }
          ];
        };
      };
    };
  };
}
