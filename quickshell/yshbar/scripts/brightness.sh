#!/bin/sh
CURRENT_BRIGHTNESS=$(brightnessctl | grep -oP '\d+(?=%)')
STEP=5

brightness_current() {
    notify-send "Device Brightness" "Current value: ${CURRENT_BRIGHTNESS}%"
}

brightness_cycle() {
    local GET_BRIGHTNESS=$(brightnessctl get)
    local MAX_BRIGHTNESS=$(brightnessctl max)
    local BRIGHTNESS_PERCENT=$((GET_BRIGHTNESS * 100 / MAX_BRIGHTNESS))

    if [ "${BRIGHTNESS_PERCENT}" -lt 30 ]; then
        brightnessctl set 40% -q
        notify-send "Device Brightness" "Current value: 40%"
    elif [ "${BRIGHTNESS_PERCENT}" -lt 60 ]; then
        brightnessctl set 70% -q
        notify-send "Device Brightness" "Current value: 70%"
    elif [ "${BRIGHTNESS_PERCENT}" -lt 80 ]; then
        brightnessctl set 100% -q
        notify-send "Device Brightness" "Current value: 100%"
    else
        brightnessctl set 10% -q
        notify-send "Device Brightness" "Current value: 10%"
    fi
}

increase_brightness() {
    CURRENT_BRIGHTNESS=$((CURRENT_BRIGHTNESS + 5))
    brightnessctl set -q +${STEP}%
    if [[ ${CURRENT_BRIGHTNESS} -ge 100 ]]; then
        brightnessctl set -q 100%
        CURRENT_BRIGHTNESS=100
    elif [[ ${CURRENT_BRIGHTNESS} -le 0 ]]; then
        brightnessctl set -q 0%
        CURRENT_BRIGHTNESS=0
    fi
    brightness_current
}

decrease_brightness() {
    CURRENT_BRIGHTNESS=$((CURRENT_BRIGHTNESS - 5))
    brightnessctl set -q ${STEP}%-
    if [[ ${CURRENT_BRIGHTNESS} -ge 100 ]]; then
        brightnessctl set -q 100%
        CURRENT_BRIGHTNESS=100
    elif [[ ${CURRENT_BRIGHTNESS} -le 0 ]]; then
        brightnessctl set -q 0%
        CURRENT_BRIGHTNESS=0
    fi
    brightness_current
}

case "$1" in
    "--current")
        brightness_current
        ;;
    "--cycle")
        brightness_cycle
        ;;
    "--inc")
        increase_brightness
        ;;
    "--dec")
        decrease_brightness
        ;;
    *)
        brightness_cycle
        ;;
esac
