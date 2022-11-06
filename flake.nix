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
    nixpkgs.url = "nixpkgs/nixos-22.05";
    
    nixos-hardware.url = github:nixos/nixos-hardware/master;

    agenix.url = "github:ryantm/agenix";
    
    emacs = {
      url = "github:nix-community/emacs-overlay/";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, emacs, agenix, ... }@inputs:

    let
      system = "x86_64-linux";
      username = "kandread";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          emacs.overlay
        ];
      };
    in {
      nixosConfigurations = {
        amdgland = nixpkgs.lib.nixosSystem {
          inherit pkgs system;

          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t495
            agenix.nixosModule
            { age.secrets.umass.file = ./secrets/umass.age; }
            ./hosts/amdgland
          ];
        };
      };
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit system username pkgs;
        configuration = import ./user/home.nix;
        homeDirectory = "/home/${username}";
        stateVersion = "22.05";
      };
    };
}
