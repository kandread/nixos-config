{

  programs.home-manager.enable = true;

  home = {
    username = "kandread";
    homeDirectory = "/home/kandread";
    stateVersion = "22.11";
  };

  imports = [
    ./programs.nix
    ./packages.nix
    ./emacs.nix
    ./shells.nix
    ./email.nix
    ./julia.nix
    ./theming.nix
  ];

}
