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
    # hunspell
    # hunspellDicts.en_US-large

    # Web
    brave
    unstable.firefox
    qutebrowser
    hugo

    # Viewers
    qpdfview

    # Communication
    zoom-us
    unstable.mattermost-desktop
    matterircd
    # teams

    # Shells
    any-nix-shell

    # Science
    netcdf
    # qgis
    gdal
    grass
    python3Packages.numpy # for GDAL Python modules
    python3Packages.wxPython_4_2

    # Multimedia
    feh
    imagemagick
    obs-studio
    pulsemixer
    pamixer
    easyeffects

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
    trayer
    xkb-switch
    xdotool

    # Libraries
    nodejs
    go

    # Development
    gcc
    automake
    autoconf
    gnumake
    tree-sitter

    # Fonts
    nerdfonts
    symbola
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    font-awesome
  ];

}
