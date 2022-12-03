# nixos-config
My NixOS configuration in a flake. For now I'm using the latest stable release of NixOS (22.11) with overlays for some packages (e.g., Stumpwm) that appear to be broken in the unstable nixpkgs. The directory structure I follow (probably not best practice) includes:

- `hosts`: common and specific configuration for my different machines
- `modules`: custom NixOS modules
- `user`: home-manager and program configuration
- `secrets`: contains age-encrypted passwords managed with [agenix](https://github.com/ryantm/agenix)
- `overlays`: override package settings with overlays


