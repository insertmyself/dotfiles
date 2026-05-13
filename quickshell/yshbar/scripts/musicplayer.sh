#!/bin/sh
STEP=5
PLAYER_STATUS=$(playerctl --player=mpd status)
CURRENT_VOLUME=$(mpc volume | grep -o '[0-9]\+')

send_notification() {
    TRACK_INFO="$(mpc current --format '%title% - %artist%')"
    ALBUM_ART="${HOME}/.local/share/albums/${TRACK_INFO}.png"

    if [[ -n "${TRACK_INFO}" ]] && [[ -f "${ALBUM_ART}" ]]; then
        notify-send -i "file://${ALBUM_ART}" "$1" "$2"
    else
        notify-send "$1" "$2"
    fi
}

music_current() {
    send_notification "Current Track" "$(mpc current --format '%title% - %artist%')"
}

music_toggle() {
    if [[ ${PLAYER_STATUS} == "Paused" ]]; then
        mpc play --quiet
        send_notification "Current Track" "$(mpc current --format '%title% - %artist%')"
    elif [[ ${PLAYER_STATUS} == "Playing" ]]; then
        mpc pause --quiet
        send_notification "Music Status" "Music player paused"
    else
        send_notification "Music Status" "Music player paused"
    fi
}

music_next() {
    if [[ ${PLAYER_STATUS} == "Paused" ]]; then
        mpc play --quiet
        send_notification "Current Track" "$(mpc current --format '%title% - %artist%')"
    elif [[ ${PLAYER_STATUS} == "Playing" ]]; then
        mpc next --quiet
        send_notification "Next Track" "$(mpc current --format '%title% - %artist%')"
    else
        send_notification "Music Status" "Music player paused"
    fi
}

music_prev() {
    if [[ ${PLAYER_STATUS} == "Paused" ]]; then
        mpc play --quiet
        send_notification "Current Track" "$(mpc current --format '%title% - %artist%')"
    elif [[ ${PLAYER_STATUS} == "Playing" ]]; then
        mpc prev --quiet
        send_notification "Prev Track" "$(mpc current --format '%title% - %artist%')"
    else
        send_notification "Music Status" "Music player paused"
    fi
}

increase_vol() {
    CURRENT_VOLUME=$((CURRENT_VOLUME + 5))
    mpc volume --quiet +${STEP}
    if [[ ${CURRENT_VOLUME} -ge 100 ]]; then
        mpc volume --quiet 100
        CURRENT_VOLUME=100
    elif [[ ${CURRENT_VOLUME} -le 0 ]]; then
        mpc volume --quiet 0
        CURRENT_VOLUME=0
    fi
    send_notification "Music Volume" "Current volume: ${CURRENT_VOLUME}%"
}

decrease_vol() {
    CURRENT_VOLUME=$((CURRENT_VOLUME - 5))
    mpc volume --quiet -${STEP}
    if [[ ${CURRENT_VOLUME} -ge 100 ]]; then
        mpc volume --quiet 100
        CURRENT_VOLUME=100
    elif [[ ${CURRENT_VOLUME} -le 0 ]]; then
        mpc volume --quiet 0
        CURRENT_VOLUME=0
    fi
    send_notification "Music Volume" "Current volume: ${CURRENT_VOLUME}%"
}

case "$1" in
    "--current")
        music_current
        ;;
    "--toggle")
        music_toggle
        ;;
    "--rmpc")
        rmpc_check
        ;;
    "--change-next")
        music_next
        ;;
    "--change-prev")
        music_prev
        ;;
    "--inc")
        increase_vol
        ;;
    "--dec")
        decrease_vol
        ;;
    *)
        music_current
        ;;
esac
