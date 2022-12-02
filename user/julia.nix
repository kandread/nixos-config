{ pkgs, ... }:

let
  fixJuliaPkgs = pkgs.writeShellScriptBin "fixJuliaPkgs" ''
    PKG_DIR=~/.julia/

    for ARTIFACT in $(find $PKG_DIR/artifacts/*/bin/*) 
    do
      chmod +w $ARTIFACT
      ${pkgs.patchelf}/bin/patchelf --set-interpreter ${pkgs.stdenv.cc.bintools.dynamicLinker} $ARTIFACT 2> /dev/null
      chmod -w $ARTIFACT
    done
    '';
in
{
  home.packages = [
    pkgs.julia-bin
    pkgs.patchelf
    fixJuliaPkgs
  ];
}
