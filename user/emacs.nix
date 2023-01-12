{ pkgs, config, lib, ... }:
{

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit;
    extraPackages = epkgs: with epkgs; [
      vterm
    ];
  };

}
