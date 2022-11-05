{ pkgs, config, lib, ... }:

# for singleton
with lib;

let
  cfg = config.services.xserver.windowManager;
  stumpwm-wrapper = (
    # based on https://github.com/lihebi/nixos/blob/master/pkgs/stumpwm-wrapper.nix

    pkgs.stdenv.mkDerivation rec {
      pname = "stumpwm-wrapper";
      version = "0.0.1";
      unpackPhase = "true";

      # FIXME propagatedInputs?
      buildInputs = [ pkgs.lispPackages.stumpwm
                      pkgs.lispPackages.clwrapper
                      pkgs.lispPackages.swank
                      pkgs.lispPackages.clx-truetype
                      pkgs.lispPackages.xembed ];

      buildPhase = ''
      ''; 

      # this packages up an execution environment for sbcl that can load stumpwm with everything it needs for my config
      # XXX: can we just do this with a stumpwm package override instead setting buildinputs?
      # XXX: see https://discourse.nixos.org/t/stumpwm-contrib-xembed-help/2510/2
      installPhase = ''
      mkdir -p $out/bin 
      script="$out"/bin/stumpwm-wrapper.sh
      mkdir -p "$(dirname "$script")"
      touch "$script"
      chmod a+x "$script"
      echo "#! ${pkgs.stdenv.shell}" >> "$script"
      echo "source ${pkgs.lispPackages.stumpwm}/lib/common-lisp-settings/stumpwm-shell-config.sh" >> "$script"
      echo "source ${pkgs.lispPackages.clx-truetype}/lib/common-lisp-settings/clx-truetype-shell-config.sh" >> "$script"
      echo "source ${pkgs.lispPackages.swank}/lib/common-lisp-settings/swank-shell-config.sh" >> "$script"
      echo "source ${pkgs.lispPackages.xembed}/lib/common-lisp-settings/xembed-shell-config.sh" >> "$script"
      echo '"${pkgs.lispPackages.clwrapper}/bin/common-lisp.sh" --quit --eval "(require :stumpwm)" --eval "(stumpwm:stumpwm)"' >> "$script"
      '';

      meta = with lib; {
        homepage = https://github.com/stumpwm/stumpwm;
        description = "A wrapper to use common-lisp.sh to launch stumpwm";
        license = licenses.gpl2;
        maintainers = [ maintainers.hebi ];
        platforms = platforms.unix;
      };
    });
in
{
  options = {
    services.xserver.windowManager.stumpwm-wrapper.enable = mkEnableOption "stumpwm-wrapper";
  };

  config = mkIf cfg.stumpwm-wrapper.enable {
    services.xserver.windowManager.session = singleton {
      name = "stumpwm-wrapper";
      start = ''
        ${stumpwm-wrapper}/bin/stumpwm-wrapper.sh &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ stumpwm-wrapper ];
  };
}
