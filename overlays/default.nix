{ unstable }:

self: super: {

  unstable = import unstable {
    system = "${super.system}";
    config.allowUnfree = true;
  };

  brave = super.brave.overrideAttrs (_: rec {
    version = "1.45.125";
    src = super.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser_${version}_amd64.deb";
      sha256 = "sha256-jO8GR9e9cms0ftJ6bvrIR9H7YgAjohHgkANfnblP6+k=";
    };
  });

  zoom-us = super.zoom-us.overrideAttrs (_: rec {
    version = "5.12.6.173";
    src = super.fetchurl {
      url = "https://zoom.us/client/5.12.6.173/zoom_x86_64.pkg.tar.xz";
      sha256 = "sha256-8/xH2Z9MbNx+/e2tWj5fv0A1cMn8h0bSbVJ+REk3YZo=";
    };
  });

}
