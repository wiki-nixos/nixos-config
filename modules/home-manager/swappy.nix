{ pkgs, ... }:
{
  home.packages = with pkgs; [ swappy ];

  home.file = {
    ".config/swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures/screenshots
      save_filename_format=screenshot-%Y%m%d-%H%M%S.png 
    '';
  };
}

