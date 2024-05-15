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
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

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
"SUPER Return" "Open Terminal" "kitty" \
"SUPER T" "Open Thunar" "thunar" \
"SUPER H" "Open Keybinds Menu" "/etc/nixos/modules/home-manager/scripts/keybinds.sh" \
"SUPER Q" "Kill Active Window" "killactive" \
"SUPER V" "Toggle Floating" "togglefloating" \
"SUPER D" "App Launcher" "rofi -show drun -config /etc/nixos/modules/home-manager/rofi/rofidmenu.rasi" \
"SUPER ALT V" "Clipboard Manager" "/etc/nixos/modules/home-manager/scripts/clipboard.sh" \
"SUPER SHIFT Q" "Open wlogout" "/etc/nixos/modules/home-manager/scripts/poweroff.sh" \
"SUPER P" "Pseudo Mode" "pseudo" \
"SUPER J" "Toggle Split" "togglesplit" \
"SUPER S" "Take Screenshot" "/etc/nixos/modules/home-manager/scripts/screenshot.sh" \
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