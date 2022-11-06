{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Editors
    vim
    
    # Writing
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    libreoffice-fresh
    pandoc
    texlive.combined.scheme-full

    # Web
    firefox
    
    # Communication
    zoom-us
    unstable.davmail

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
    gnumake

    # Fonts
    nerdfonts
    symbola
  ];

}
