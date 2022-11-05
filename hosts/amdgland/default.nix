{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common.nix
    ];

  networking.hostName = "amdgland"; # Define your hostname.

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  }
