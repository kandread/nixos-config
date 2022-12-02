{
  description = "NixOS configuration flake for all my machines";

  nixConfig = {
    trusted-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nixos-hardware.url = github:nixos/nixos-hardware/master;

    agenix.url = "github:ryantm/agenix";
    
    emacs = {
      url = "github:nix-community/emacs-overlay?rev=aa91ccd60349c0361ab920fcfe2602bf894edf6d";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, unstable, emacs, agenix, ... }@inputs:

    let
      system = "x86_64-linux";
      username = "kandread";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          (import ./overlays { unstable = unstable; })
          emacs.overlay
        ];
      };
    in {
      nixosConfigurations = {
        amdgland = nixpkgs.lib.nixosSystem {
          inherit pkgs system;

          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t495
            agenix.nixosModules.age
            ./hosts/amdgland
          ];
        };

        thingland = nixpkgs.lib.nixosSystem {
          inherit pkgs system;

          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-p53
            agenix.nixosModules.age
            ./hosts/thingland
          ];
        };
      };
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./user/home.nix
        ];
      };
    };
}
