{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    #theme = "Catppuccin-Mocha";
    # Adjustments for font configuration according to the NixOS options
    font = {
      name = "Fira Code";
      # Adding font size as it's commonly needed, adjust as necessary
      size = 13;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      background_opacity = "0.8";

      # tab bar settings
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      # Fixed typo from `tab_powerline_syle` to `tab_powerline_style`
      tab_powerline_style = "angled";
      tab_title_template = "{title}{ ' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
  };
}
