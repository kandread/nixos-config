# nixos-config
My NixOS configuration in a flake. For now I'm using the latest stable release of NixOS (22.05) as some packages (e.g., Stumpwm) appear to be broken in the unstable nixpkgs. The directory structure I follow (probably not best practice) includes:

- `hosts`: common and specific configuration for my different machines
- `modules`: custom NixOS modules
- `user`: home-manager and program configuration


