{ pkgs, ... }:
{
  xsession = {
    enable = true;
    pointerCursor = {
      size = 32;
      package = pkgs.nordzy-cursor-theme;
    };
  };
}
