{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
      ../services.nix
      ../common.nix
    ];

  # fix for recognizing webcam (https://forums.linuxmint.com/viewtopic.php?t=339218)
  boot.extraModprobeConfig = ''
    options uvcvideo quirks=4
  '';

  networking.hostName = "thingland"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.enp0s31f6.useDHCP = true;
  # networking.interfaces.wlp82s0.useDHCP = true;

  # Do not suspend when closing the lid
  services.logind.lidSwitch = "ignore";

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
    mouse.naturalScrolling = true;
  };

  # NVIDIA drivers
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

}

