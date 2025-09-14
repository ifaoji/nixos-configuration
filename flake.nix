{
  description = "My NixOS configuration?";

  inputs = {
    self.submodules = true;
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    zen-browser-flake.url = "path:./flakes/zen-browser";
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
            ./configuration.nix
            ./hosts/ft-laptop/hardware-configuration.nix
          ];
        };
      };
    };
}
