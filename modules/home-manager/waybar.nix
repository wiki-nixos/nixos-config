{ pkgs, ... }:
{
programs.waybar =
{
  enable = true;

  settings = [{
    name = "topbar";
    layer = "top";
    position = "top";
    modules-left = [ "hyprland/workspaces" ];
    modules-center = [ "clock" ];
    modules-right = [ "battery" "tray" ];
    "hyprland/workspaces" = {
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
      };
      sort-by-number = true;
    };
    battery = {
      format = "{capacity}% {icon}";
      format-icons = [ "" "" "" "" "" ];
    };
    tray = {
      icon-size = 21;
      spacing = 10;
    };
    clock = {
      format-all = "{:%a, %d. %b %H:%M}";
    };

  }];

  style = ''
  * {
      border: none;
      border-radius: 0;
      font-family: "Jetbrains Mono", "Font Awesome 6 Free Solid";
      font-size: 20px;
      min-height: 0;
  }

  window#waybar {
      background-color: rgba(0, 0, 0, 0.75);
      color: #fff;
  }

  window#waybar.hidden {
      opacity: 0.2;
  }

  window#waybar.empty {
      /* color: #15161e; */
  }

.topbar {
    border-bottom: 3px solid #fff;
}

.bottombar {
    border-top: 3px solid #fff;
}

#workspaces button {
    /* padding: 0 5px; */
    background-color: transparent;
    color: #fff;
    margin: 0;
    min-width: 5px;
}

#workspaces button.focused {
    background-color: #1b1b1b;
    box-shadow: inset 0 3px #ffffff;
}

#workspaces button.urgent {
    background-color: #ff9e64;
}

#mode {
    background-color: #1b1b1b;
    border-top: 3px solid #ffffff;
}

#workspaces button:first-child {
    border-left: 0;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
    box-shadow: inherit;
    text-shadow: inherit;
}


#backlight,
#battery.bat1,
#battery.bat2,
#clock,
#cpu,
#custom-mail,
#custom-poweroff,
#custom-weather,
#disk,
#idle_inhibitor,
#memory,
#mode,
#network.vpn,
#network.wifi,
#network.ethernet,
#network.disconnected,
#pulseaudio,
#taskbar,
#temperature,
#tray {
    padding: 0 6px;
    margin: 0 0px;
    color: #fff;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}

#battery.bat2.critical:not(.charging) {
    background-color: #f53c3c;
    color: #000;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#temperature.critical {
    background-color: #eb4d4b;
}

#taskbar button:hover {
    background: rgba(0, 0, 0, 0.2);
    box-shadow: inset 0 3px #ffffff;
}

#taskbar button.active {
    background-color: #1b1b1b;
    box-shadow: inset 0 3px #ffffff;
}
  '';

};
}
