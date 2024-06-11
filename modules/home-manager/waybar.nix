{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    settings = [
      {
        name = "topbar";
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" "cpu" "disk" "memory" "temperature" "pulseaudio" "backlight" "battery"];
        modules-center = ["hyprland/window"];
        modules-right = ["network" "custom/weather" "tray" "clock" "custom/keybinds" "custom/poweroff"];
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
            "10" = "10";
          };
          sort-by-number = true;
        };
        "hyprland/window" = {
          max-length = 70;
        };
        battery = {
          interval = 1;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "{capacity}% ";
          format-icons = [" " " " " " " " " "];
          max-length = 25;
        };
        tray = {
          icon-size = 21;
          spacing = 10;
        };
        clock = {
          format-all = "{:%a, %d. %b %H:%M}";
        };
        cpu = {
          format = "  {usage}%";
          tooltip = false;
        };
        disk = {
          format = "  {}%";
          tooltip-format = "{used} / {total} used";
        };
        memory = {
          format = "  {}%";
          tooltip-format = "{used:0.1f}G / {total:0.1f}G used";
        };
        temperature = {
          criticalThreshold = 80;
          format = " {temperatureC}°C";
        };
        backlight = {
          device = "intel_backlight";
          interval = 1;
          onScrollDown = "brightlight -pd 1";
          onScrollUp = "brightlight -pi 1";
          format = "  {percent}%";
          onClick = "wdisplays";
        };
        battery.bat1 = {
          bat = "BAT0";
          adapter = "AC";
          interval = 10;
          fullAt = 99;
          states = {
            full = 100;
            good = 99;
            empty = 5;
          };
          format = "  {capacity}%";
        };
        battery.bat2 = {
          bat = "BAT1";
          adapter = "AC";
          interval = 10;
          states = {
            full = 100;
            good = 99;
            critical = 15;
          };
          format = "  {capacity}%";
        };
        network = {
          disconnected = {
            tooltip-format = "No connection!";
            format-ethernet = "";
            format-wifi = "";
            format-linked = "";
            format-disconnected = "";
            on-click = "nm-connection-editor";
          };
          ethernet = {
            interface = "enp*";
            format-ethernet = "";
            format-wifi = "";
            format-linked = "";
            format-disconnected = "";
            tooltip-format = "{ifname}: {ipaddr}/{cidr}";
            on-click = "nm-connection-editor";
          };
          wifi = {
            interface = "wlp*";
            format-ethernet = "";
            format-wifi = "  {essid} ({signalStrength}%)";
            format-linked = "";
            format-disconnected = "";
            tooltip-format = "{ifname}: {ipaddr}/{cidr}";
            on-click = "nm-connection-editor";
          };
          vpn = {
            interface = "tun0";
            format = "";
            format-disconnected = "";
            tooltip-format = "{ifname}: {ipaddr}/{cidr}";
            on-click = "nm-connection-editor";
          };
        };
        pulseaudio = {
          scroll-step = 1;
          format = "{icon} {volume}%{format_source}";
          format-bluetooth = "{icon}  {volume}%{format_source}";
          format-bluetooth-muted = " {icon}  {format_source}";
          format-muted = "M {format_source}";
          format-source = "  {volume}%";
          format-source-muted = "  ";
          format-icons = {
            headphone = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = ["" " " "  "];
          };
          on-click = "pavucontrol";
        };
        "custom/weather" = {
          exec = "sh get-weather";
          interval = 300;
          onClick = "firefox https://wttr.in";
        };
        "custom/poweroff" = {
          format = " ";
          on-click = "wlogout";
        };
        "custom/keybinds" = {
          format = "  ";
          on-click = "sh keybinds";
        };
      }
    ];

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

      /*
      .topbar {
          border-bottom: 3px solid #fff;
      }

      .bottombar {
          border-top: 3px solid #fff;
      }
      */

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
      #idleInhibitor,
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
