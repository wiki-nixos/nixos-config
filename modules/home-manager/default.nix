# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# #These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  git = import ./git.nix;
  kitty = import ./kitty.nix;
  neovim = import ./neovim.nix;
  firefox = import ./firefox.nix;
  vscode = import ./vscode.nix;
  btop = import ./btop.nix;
  dunst = import ./dunst.nix;
  gtk = import ./gtk.nix;
  qt = import ./qt.nix;
  hyprland = import ./hyprland.nix;
  waybar = import ./waybar.nix;
  zsh = import ./zsh.nix;
  wlogout = import ./wlogout.nix;
  swaylock = import ./swaylock.nix;
  swayidle = import ./swayidle.nix;
  swappy = import ./swappy.nix;
  lunarvim = import ./lunarvim.nix;
  cmus = import ./cmus.nix;
  tmux = import ./tmux.nix;
  starship = import ./starship.nix;
}
