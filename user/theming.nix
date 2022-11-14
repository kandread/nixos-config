{ pkgs, ... }:
{
  home.pointerCursor = {
    package = pkgs.nordzy-cursor-theme;
    name = "nordzy";
    size = 40;
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };
}
