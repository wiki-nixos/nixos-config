{ config, pkgs,... }:

{
  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    events = [
      {
        event = "before-sleep";
        command = "swaylock";
      }
      {
        event = "lock";
        command = "swaylock";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "swaylock -fF";
      }
    ];
  };
}

