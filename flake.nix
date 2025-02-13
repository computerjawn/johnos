{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, ... }:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      # Note that you cannot put arbitrary configuration here: the configuration must be placed in the files loaded via modules
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
