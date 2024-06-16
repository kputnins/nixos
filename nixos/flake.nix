{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    solaar = {
      # url = "github:Svenum/Solaar-Flake/latest;"; # For latest stable version
      url = "github:Svenum/Solaar-Flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gc-env.url = "github:Julow/nix-gc-env";

    musnix.url = "github:musnix/musnix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, solaar, musnix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          solaar.nixosModules.default
          inputs.home-manager.nixosModules.default
          musnix.nixosModules.musnix
        ];
      };

    };
}
