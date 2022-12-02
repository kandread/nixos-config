{ pkgs, config, lib, ... }:
{

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGitNativeComp;
    extraPackages = epkgs: with epkgs; [
      vterm
    ];
  };

}
