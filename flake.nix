{
  description = "NixOS configuration flake for all my machines";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    
    nixos-hardware.url = github:nixos/nixos-hardware/master;

    emacs = {
      url = "github:nix-community/emacs-overlay/";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, emacs, ... }@inputs:

  let
    system = "x86_64-linux";
    username = "kandread";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
  in {
    nixosConfigurations = {
      amdgland = nixpkgs.lib.nixosSystem {
          inherit pkgs system;

          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t495
            ./hosts/amdgland
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
