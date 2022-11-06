{ pkgs, ... }:
{

programs.fish = {
  enable = true;
  interactiveShellInit = ''
    starship init fish | source
  '';
};

programs.starship = {
  enable = true;
};

 programs.kitty = {
    enable = true;
    theme = "ayu";
    font = {
      name = "Roboto Nerd Mono";
      size = 13;
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
