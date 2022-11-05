{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Editors
    vim
    
    # Writing
    libreoffice-fresh
    pandoc
    texlive.combined.scheme-full

    # Web
    firefox
    
    # Communication
    zoom-us

    # Shells
    any-nix-shell
    zsh

    # Utilities
    gnupg
    ripgrep
    coreutils
    fd
    fzf
    fasd
    exa
    bottom
    bat
    powertop
    unzip
    xorg.xmodmap
    xorg.xev
    betterlockscreen

   # Development
    gcc
    automake
    autoconf

   # Fonts
    nerdfonts
    symbola
  ];

}
