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
    brave
    unstable.firefox
    
    # Communication
    zoom-us
    unstable.mattermost-desktop

    # Shells
    any-nix-shell

    # Science
    netcdf

    # Multimedia
    feh
    imagemagick
    obs-studio

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
    picom

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
