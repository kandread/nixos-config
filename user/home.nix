{

  programs.home-manager.enable = true;

  home = {
    username = "kandread";
    homeDirectory = "/home/kandread";
    stateVersion = "22.05";
  };

  imports = [
    ./programs.nix
    ./packages.nix
  ];

}
