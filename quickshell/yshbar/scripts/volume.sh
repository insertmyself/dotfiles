#!/bin/sh
CURRENT_VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
CURRENT_STATE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
STEP=5

toggle_volume() {
    if [ ${CURRENT_STATE} == "no" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ 1
        notify-send "Speaker Status" "Current State: Muted"
    elif [ ${CURRENT_STATE} == "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ 0
        notify-send "Speaker Status" "Current State: Unmuted"
    fi
}

show_state() {
    if [ ${CURRENT_STATE} == "no" ]; then
        notify-send "Speaker Status" "Current State: Unmuted"
    elif [ ${CURRENT_STATE} == "yes" ]; then
        notify-send "Speaker Status" "Current State: Muted"
    fi
}

show_volume() {
    notify-send "Speaker Volume" "Current Value: ${CURRENT_VOLUME}%"
}

increase_volume() {
    CURRENT_VOLUME=$((CURRENT_VOLUME + 5))
    pactl set-sink-volume @DEFAULT_SINK@ +${STEP}%
    if [[ ${CURRENT_VOLUME} -ge 100 ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ 100%
        CURRENT_VOLUME=100
    elif [[ ${CURRENT_VOLUME} -le 0 ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ 0
        CURRENT_VOLUME=0
    fi
    show_volume
}

decrease_volume() {
    CURRENT_VOLUME=$((CURRENT_VOLUME - 5))
    pactl set-sink-volume @DEFAULT_SINK@ -${STEP}%
    if [[ ${CURRENT_VOLUME} -ge 100 ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ 100%
        CURRENT_VOLUME=100
    elif [[ ${CURRENT_VOLUME} -le 0 ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ 0
        CURRENT_VOLUME=0
    fi
    show_volume
}

case "$1" in
    "--toggle")
        toggle_volume
        ;;
    "--state")
        show_state
        ;;
    "--inc")
        increase_volume
        ;;
    "--dec")
        decrease_volume
        ;;
    *)
        show_volume
        ;;
esac
