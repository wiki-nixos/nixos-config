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
          set -g @tmux_power_theme '#7CA3F1'
        '';
      }
    ];

    extraConfig = ''
      set -g mouse on
      set -g allow-passthrough on
    '';
  };
}
