{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = power-theme;
        extraConfig = ''
          set -g @tmux_power_theme '#ffffff'
        '';
      }
    ];

    extraConfig = ''
      set -g mouse on
      set -g allow-passthrough on
    '';
  };
}
