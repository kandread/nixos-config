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
    zotero
    obsidian
    xournalpp
    texlab

    # Web
    brave
    unstable.firefox
    qutebrowser

    # Communication
    zoom-us
    unstable.mattermost-desktop

    # Shells
    any-nix-shell

    # Science
    netcdf
    qgis

    # Multimedia
    feh
    imagemagick
    obs-studio
    pulsemixer
    pamixer

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
    tree-sitter

    # Fonts
    nerdfonts
    symbola
  ];

}
