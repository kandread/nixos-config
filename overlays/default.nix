{ unstable }:

self: super: {

  unstable = import unstable {
    system = "${super.system}";
    config.allowUnfree = true;
  };

  zoom-us = super.zoom-us.overrideAttrs (_: rec {
    version = "5.12.6.173";
    src = super.fetchurl {
      url = "https://zoom.us/client/5.12.6.173/zoom_x86_64.pkg.tar.xz";
      sha256 = "sha256-8/xH2Z9MbNx+/e2tWj5fv0A1cMn8h0bSbVJ+REk3YZo=";
    };
  });

}
