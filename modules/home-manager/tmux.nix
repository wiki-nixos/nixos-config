{pkgs, ...}: {
  home.packages = with pkgs; [tmux];
  home.file.".tmux.conf".text = builtins.readFile ./tmux/.tmux.conf;
}
