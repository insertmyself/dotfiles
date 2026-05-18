#!/bin/sh
OPTIONS=("App Selector" "Install Program" "Emoji Picker" "Wallpaper Selector" "Start Recording" "Stop Recording")
SELECTED=$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -theme-str "configuration { show-icons: false; } window { width: 24%; } listview { lines: 10; }" -p " Menu" -i -no-fixed-num-lines)

case "${SELECTED}" in
    "Wallpaper Selector")
        $HOME/.config/hypr/scripts/wallpaper.sh --picker
        ;;
    "App Selector")
        rofi -show drun -display-drun " Apps" -i -no-fixed-num-lines
        exit 0
        ;;
    "Install Program")
        $HOME/.config/niri/scripts/menus/installer.sh
        exit 0
        ;;
    "Emoji Picker")
        rofi -show emoji -theme-str "configuration { show-icons: false; }" -i -no-fixed-num-lines
        ;;
    "Start Recording")
        notify-send "Recording Utility" "Recording started" && pgrep wf-recorder | wf-recorder -b 20000k -r 60 -c libx264 -g 1366x768 --audio=$(pactl get-default-sink).monitor -f $HOME/Videos/Recorded-at-$(date +%Y-%m-%d_%H-%M-%S).mp4        RECORDING_STUFF="Stop Recording"
        ;;
    "Stop Recording")
        pkill -INT wf-recorder && notify-send "Recording Utility" "Recording stopped"
        ;;
esac
