{
  description = "My NixOS configuration?";

  inputs = {
    self.submodules = true;
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    zen-browser-flake.url = "path:./flakes/zen-browser";
    home-manager-flake = {
      url = "path:./flakes/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "phi";
    in {
      nixosConfigurations = {
        ft-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit username; inherit inputs; };
          modules = [
            inputs.home-manager-flake.nixosModules.home-manager
            ./configuration.nix
            ./hosts/ft-laptop/default.nix
            ./modules
          ];
        };

        ft-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit username; inherit inputs; };
          modules = [
            inputs.home-manager-flake.nixosModules.home-manager
            ./configuration.nix
            ./hosts/ft-desktop/hardware-configuration.nix
            ./modules
          ];
        };
      };
    };
}
