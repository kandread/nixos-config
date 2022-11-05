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

    programs.ssh = {
      enable = true;
      matchBlocks.delgland = {
        hostname = "128.119.85.180";
        user = "kandread";
      };
      matchBlocks.thingland = {
        hostname = "192.168.1.11";
        user = "kandread";
      };
      matchBlocks.adpc = {
        hostname = "58.137.55.228";
        user = "ubuntu";
      };
      matchBlocks.picore = {
        hostname = "192.168.1.12";
        user = "tc";
      };
      matchBlocks.amdgland = {
        hostname = "192.168.1.15";
        user = "kandread";
      };
      matchBlocks.unity = {
        user = "kandread_umass_edu";
        hostname = "unity.rc.umass.edu";
        identityFile = "~/.ssh/unity.key";
      };
    };


}
