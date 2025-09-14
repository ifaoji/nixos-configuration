{
  description = "My NixOS configuration?";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "phi";
    in {
      nixosConfigurations = {
        ft-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit username; };
          modules = [
            ./configuration.nix
            ./hosts/ft-laptop/hardware-configuration.nix
          ];
        };
      };
    };
}
