{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
      ../common.nix
    ];

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "amdgland"; # Define your hostname.

  # Explicitly enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

}
