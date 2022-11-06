{ pkgs, ... }:
{

programs.fish = {
  enable = true;
  shellInit = ''
    starship init fish | source
  '';
};

programs.starship = {
  enable = true;
};

}
