{
    description = "Hakiz-nix Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations= {

            #vm just a demo not use
            vm = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
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

        #nix run ~/hakiz-nix#homeConfigurations.wsl.activationPackage
        homeConfigurations = {
            wsl = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home/wsl-home.nix ];
                extraSpecialArgs = { inherit inputs; };
            };
        };
    };
}
