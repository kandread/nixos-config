{ pkgs, ... }:
{

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      ls = "exa";
      tree = "exa -T";
      cat = "bat --style=plain";
      m = "mkdir -p";
      fcd = "cd $(fd --type d | fzf)";
      grep = "rg";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      "nix_shell" = {
        impure_msg = "[impure shell](bold red)";
        pure_msg = "[pure shell](bold green)";
        format = "via [☃️ $state( \($name\))](bold blue) ";
      };
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Ayu";
    font = {
      name = "Roboto Nerd Mono";
      size = 16;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      strip_trailing_spaces = "smart";
      tab_bar_style = "separator";
      tab_bar_align = "center";
      tab_separator = "|";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index}:{title}";
      shell = "${pkgs.fish}/bin/fish";
    };
  };

}
