{
  description = "Hakiz-nix Flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        #vm just a demo not use
        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./system/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.hakiz = import ./home/hakiz-vm.nix;
            }
          ];
        };
      };

      #nix run ~/myNix#homeConfigurations.linux.activationPackage
      homeConfigurations = {
        "linux" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/linux-home.nix ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
