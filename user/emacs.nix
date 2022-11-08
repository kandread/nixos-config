{ pkgs, config, lib, ... }:
{

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkNativeComp;
    extraPackages = epkgs: with epkgs; [
      vterm
    ];
  };

}
