# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  git = import ./git.nix;
  kitty = import ./kitty.nix; 
  fish = import ./fish.nix;
  neovim = import ./neovim.nix;
  firefox = import ./firefox.nix;
  vscode = import ./vscode.nix;
  btop = import ./btop.nix;
#  sway = import ./sway.nix;
}
