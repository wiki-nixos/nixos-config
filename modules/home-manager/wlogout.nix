{
 pkgs,
 lib,
 ...
}: let
 bgImageSection = name: ''
    #${name} {
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/${name}.png"));
    }
 '';
in {
 programs.wlogout = {
    enable = true;

    style = ''
      * {
        background: none;
      }

      window {
        background-color: rgba(0, 0, 0, 0.5);
      }

      button {
        background: rgba(0, 0, 0,.05);
        border-radius: 8px;
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255,.1), 0 0 rgba(0, 0, 0,.5);
        margin: 1rem;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        background-color: rgba(255, 255, 255, 0.2);
        outline-style: none;
      }

      ${lib.concatMapStringsSep "\n" bgImageSection [
        "lock"
        "logout"
        "suspend"
        "hibernate"
        "shutdown"
        "reboot"
      ]}
    '';

    layout = [
      {
        label = "lock";
        action = "swaylock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "pkill Hyprland";
        text = "Logout";
        keybind = "o";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "s";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "shutdown";
        action = "poweroff";
        text = "Shutdown";
        keybind = "d";
      }
      {
        label = "reboot";
        action = "reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
 };
}
