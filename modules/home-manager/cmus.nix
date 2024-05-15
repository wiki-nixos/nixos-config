{ pkgs, ... }:
{
  home.packages = with pkgs; [ cmus ];

  home.file = {
    ".config/cmus/rc".text = ''
set status_display_program=cmus-notify
add /mnt/samba_share/spotify/
  '';
  };
}

