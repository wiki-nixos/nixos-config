{pkgs, ...}: {
  mount-samba = pkgs.writeShellApplication {
    name = "mount-samba";
    runtimeInputs = with pkgs; [samba];
    text = ''
      echo "Enter the IP address of the Samba server: [e.g 192.168.50.52]"
      read -r ip_address # SC2162 (info): read without -r will mangle backslashes.
      echo "Enter the name of the Samba share: [e.g samba-share]"
      read -r share_name
      echo "Enter your Samba username: [e.g smbuser]"
      read -r smb_username

      # Ask the user to enter their Samba password without echoing it
      echo "Please enter your Samba password:"
      read -sr smb_password

      # Export the password as an environment variable
      export SMB_PASSWORD=$smb_password

      # Construct the mount command using the user-provided inputs
      mount_command="sudo mkdir /mnt/samba_share ; sudo mount -t cifs //''${ip_address}/''${share_name} /mnt/samba_share -o username=''${smb_username},password=\$SMB_PASSWORD"

      # Execute the constructed mount command
      eval "''${mount_command}"

      # Inform the user about the operation result
      if eval "$mount_command"; then
          echo "Mounting was successful. [/mnt/samba_share]"
      else
          echo "Failed to mount the Samba share."
      fi
    '';
  };

  get-weather = pkgs.writeShellApplication {
    name = "get-weather";
    runtimeInputs = with pkgs; [curl];
    text = ''
      city=$(curl -s "https://ipinfo.io/city")
      weather=$(curl -s "wttr.in/''${city}?format=3")
      echo "$weather"
    '';
  };

  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [grim slurp swappy];
    text = ''
      grim -g "$(slurp)" - | swappy -f -
    '';
  };

  wallpaper-fix = pkgs.writeShellApplication {
    name = "wallpaper-fix";
    runtimeInputs = with pkgs; [swww];
    text = ''
      swww init ; swww img /etc/nixos/wallpapers/2.jpg
    '';
  };

  rainbow-borders = pkgs.writeShellApplication {
    name = "rainbow-borders";
    runtimeInputs = with pkgs; [openssl hyprland];
    text = ''
      function random_hex() {
          random_hex="0xff$(openssl rand -hex 3)"
          echo "$random_hex"
      }

      hyprctl keyword general:col.active_border "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" 270deg

      hyprctl keyword general:col.inactive_border "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" "$(random_hex)" 270deg
    '';
  };

  clipboard = pkgs.writeShellApplication {
    name = "clipboard";
    runtimeInputs = with pkgs; [rofi-wayland wl-clipboard cliphist];
    text = ''
      # Actions:
      # CTRL Del to delete an entry
      # ALT Del to wipe clipboard contents

      while true; do
          result=$(
              rofi -i -dmenu \
                  -kb-custom-1 "Control-Delete" \
                  -kb-custom-2 "Alt-Delete" \
                  -config /etc/nixos/modules/home-manager/rofi/rofidmenu.rasi < <(cliphist list)
          )

          case "$?" in
              1)
                  exit
                  ;;
              0)
                  case "$result" in
                      "")
                          continue
                          ;;
                      *)
                          cliphist decode <<<"$result" | wl-copy
                          exit
                          ;;
                  esac
                  ;;
              10)
                  cliphist delete <<<"$result"
                  ;;
              11)
                  cliphist wipe
                  ;;
          esac
      done
    '';
  };

  keybinds = pkgs.writeShellApplication {
    name = "keybinds";
    runtimeInputs = with pkgs; [hyprland jq yad];
    text = ''
      # Detect monitor resolution and scale
      x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
      y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
      hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

      # Calculate width and height based on percentages and monitor resolution
      width=$((x_mon * hypr_scale / 100))
      height=$((y_mon * hypr_scale / 100))

      # Set maximum width and height
      max_width=1200
      max_height=1000

      # Set percentage of screen size for dynamic adjustment
      percentage_width=70
      percentage_height=70

      # Calculate dynamic width and height
      dynamic_width=$((width * percentage_width / 100))
      dynamic_height=$((height * percentage_height / 100))

      # Limit width and height to maximum values
      dynamic_width=$((dynamic_width > max_width ? max_width : dynamic_width))
      dynamic_height=$((dynamic_height > max_height ? max_height : dynamic_height))

      # Launch yad with calculated width and height
      yad --width=$dynamic_width --height=$dynamic_height \
          --center \
          --title="Keybindings" \
          --no-buttons \
          --list \
          --column=Key: \
          --column=Description: \
          --column=Command: \
          --timeout-indicator=bottom \
      "SUPER W" "Open Firefox" "firefox" \
      "SUPER Return" "Open Terminal" "kitty tmux" \
      "SUPER T" "Open Thunar" "thunar" \
      "SUPER H" "Open Keybinds Menu" "keybinds" \
      "SUPER Q" "Kill Active Window" "killactive" \
      "SUPER V" "Toggle Floating" "togglefloating" \
      "SUPER D" "App Launcher" "rofi -show drun -config /etc/nixos/modules/home-manager/rofi/rofidmenu.rasi" \
      "SUPER ALT V" "Clipboard Manager" "clipboard" \
      "SUPER SHIFT Q" "Open wlogout" "wlogout" \
      "SUPER P" "Pseudo Mode" "pseudo" \
      "SUPER J" "Toggle Split" "togglesplit" \
      "SUPER S" "Take Screenshot" "screenshot" \
      "SUPER F" "Fullscreen" "fullscreen" \
      "SUPER Left" "Move Focus Left" "movefocus l" \
      "SUPER Right" "Move Focus Right" "movefocus r" \
      "SUPER Up" "Move Focus Up" "movefocus u" \
      "SUPER Down" "Move Focus Down" "movefocus d" \
      "CTRL Left" "Swap Window Left" "swapwindow l" \
      "CTRL Right" "Swap Window Right" "swapwindow r" \
      "CTRL Up" "Swap Window Up" "swapwindow u" \
      "CTRL Down" "Swap Window Down" "swapwindow d" \
      "SUPER 1" "Switch to Workspace 1" "workspace 1" \
      "SUPER 2" "Switch to Workspace 2" "workspace 2" \
      "SUPER 3" "Switch to Workspace 3" "workspace 3" \
      "SUPER 4" "Switch to Workspace 4" "workspace 4" \
      "SUPER 5" "Switch to Workspace 5" "workspace 5" \
      "SUPER 6" "Switch to Workspace 6" "workspace 6" \
      "SUPER 7" "Switch to Workspace 7" "workspace 7" \
      "SUPER 8" "Switch to Workspace 8" "workspace 8" \
      "SUPER 9" "Switch to Workspace 9" "workspace 9" \
      "SUPER SHIFT 1" "Move to Workspace 1" "movetoworkspace 1" \
      "SUPER SHIFT 2" "Move to Workspace 2" "movetoworkspace 2" \
      "SUPER SHIFT 3" "Move to Workspace 3" "movetoworkspace 3" \
      "SUPER SHIFT 4" "Move to Workspace 4" "movetoworkspace 4" \
      "SUPER SHIFT 5" "Move to Workspace 5" "movetoworkspace 5" \
      "SUPER SHIFT 6" "Move to Workspace 6" "movetoworkspace 6" \
      "SUPER SHIFT 7" "Move to Workspace 7" "movetoworkspace 7" \
      "SUPER SHIFT 8" "Move to Workspace 8" "movetoworkspace 8" \
      "SUPER SHIFT 9" "Move to Workspace 9" "movetoworkspace 9" \
      "SUPER Mouse 273" "Resize Window" "resizewindow" \
      "SUPER Mouse 272" "Move Window" "movewindow" \
      "" "" ""
    '';
  };
}
