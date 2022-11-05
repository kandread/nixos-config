{ pkgs, config, ... }:
{

  programs.git = {
      enable = true;
      extraConfig = {
        core = { compression = 0; };
        pull.rebase = false;
        status.showUntrackedFiles = "all";
        credential.helper = "store";
        user = {
          name = "Kostas Andreadis";
          email = "kandread@umass.edu";
        };
      };
      aliases = {
        s = "status";
        a = "add";
        f = "fetch";
        c = "commit -m";
        k = "checkout";
        b = "branch";
        l = "log";
        p = "pull";
        h = "push";
      };
    };

}
