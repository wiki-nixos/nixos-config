{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;    
    #initExtra = "";

    oh-my-zsh = {
      enable = true;
      #custom = ohMyZshCustom.outPath; # Use .outPath to ensure a string path is used
      theme = "agnoster";
      plugins = [ "git" ];
    };

    shellAliases = {
      ll = "ls -l";
      sysconf = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-desktop";
      homeconf = "home-manager switch --flake /etc/nixos#eternal@nixos-desktop";
      jvim = "nix run --refresh github:quantumcoded/neovim";
      code = "codium";
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
}

