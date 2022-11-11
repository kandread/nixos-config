{ config, pkgs, lib, ... }:

{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Imports
  imports = [
    ../modules/stumpwm
    ../modules/secrets
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable Window Managers.
  services.xserver.windowManager = {
    stumpwm-wrapper.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    config.pipewire = {
      "context.properties" = {
        "default.clock.allowed-rates" = [ 44100 48000 88200 96000 192000 ];
      };
    };
    wireplumber.enable = false;

    # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kandread = {
    isNormalUser = true;
    description = "Kostas Andreadis";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    cachix
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

   # Squeezelite
  services.squeezelite = {
       enable = true;
       extraArguments = let
         lms_ip = "192.168.1.12"; # local IP address for Logitech Media Server
           in
             if (config.networking.hostName == "thingland")
             then
               "-o front:CARD=TA10R,DEV=0 -s ${lms_ip}"
             else
               "-s ${lms_ip}";
     };
     # Override the need for player name file
     systemd.services.squeezelite.serviceConfig.ExecStart = let cfg = config.services.squeezelite;
                                                            in lib.mkForce "${pkgs.squeezelite}/bin/squeezelite -n ${config.networking.hostName} ${cfg.extraArguments}";

# Davmail
  systemd.user.services.davmail = {
    description = "Davmail daemon";
    serviceConfig = {
      ExecStart = "${pkgs.unstable.davmail}/bin/davmail";
      Restart = "on-failure";
    };
    path = [ pkgs.unstable.davmail ];
    enable = true;
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "kandread";
    dataDir = "/home/kandread";
    configDir = "/home/kandread/.config/syncthing";
    overrideDevices = true; # overrides any devices added or deleted through the WebUI
    overrideFolders = true; # overrides any folders added or deleted through the WebUI
    devices = {
      amdgland = "FMQGAEU-WJYVCFG-AI63QN5-DX6WVZA-T4SOYCO-RQ3TXZX-YXIZDY7-WARJAAS";
      thingland = "MOEAIAA-6O3V7X7-VGZNOAK-EJDJDLD-4Q5TZHK-PLRE7HY-Y3HV3T4-X6FANAQ";
    };
    let device_names = [ "amdgland" "thingland" ]
    in
      folders = {
        "/home/kandread/Documents/Notes" = {
          devices = device_names;
        };
      };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Garbage collect
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
