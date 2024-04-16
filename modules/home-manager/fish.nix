{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      clear
      set fish_greeting
      tide configure --auto --style=Rainbow --prompt_colors='16 colors' --show_time='24-hour format' --rainbow_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Solid --powerline_right_prompt_frame=Yes --prompt_spacing=Compact --icons='Many icons' --transient=No

      alias ll "ls -l"
      alias ls "ls -a"

      alias xps-sysconf "sudo nixos-rebuild switch --flake /etc/nixos#dell-xps"
      alias eternal-xps-homeconf "home-manager switch --flake /etc/nixos#eternal@dell-xps"

      alias thinkpad-sysconf "sudo nixos-rebuild switch --flake /etc/nixos#thinkpad"
      alias x200-thinkpad-homeconf "home-manager switch --flake /etc/nixos#x200@thinkpad"

      alias jvim "nix run --refresh github:quantumcoded/neovim"
    '';
    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    ];
  };
}

