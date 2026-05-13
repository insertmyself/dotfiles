#!/bin/sh
WALLPAPER_DIR="${HOME}/Pictures/Wallpapers"
WALLPAPER_RANDOM=$(find "${WALLPAPER_DIR}" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)
WALLPAPER_TEMPD=${HOME}/.cache/walrandom
WALLPAPER_TEMPF=${HOME}/.cache/walrandom/Cached.png
WALLPAPER_FILE=$(basename ${WALLPAPER_RANDOM})

wallpaper_random() {
    if [[ ! -d "${WALLPAPER_TEMPD}" ]]; then
        mkdir -p "${WALLPAPER_TEMPD}"
    fi
    cp ${WALLPAPER_RANDOM} ${WALLPAPER_TEMPF}
    swww img "${WALLPAPER_RANDOM}" --transition-fps 60 --transition-type outer --transition-pos center --transition-duration 1
    notify-send "Wallpaper Randomizer" "${WALLPAPER_FILE} wallpaper applied"
}

load_wallpaper() {
    if [[ -f ${WALLPAPER_TEMPF} ]]; then
        swww img ${WALLPAPER_TEMPF} --transition-fps 60 --transition-type grow --transition-pos center --transition-duration 1
    else
        swww img $(awk -F'=' "/^\\[Wallpaper\\]/{flag=1;next}/^\\[/{flag=0}flag && \$1~/LastWallpaper/{print \$2}" "${HOME}/.config/switar/config.ini" | tr -d '[:space:]') --transition-fps 60 --transition-type grow --transition-pos center --transition-duration 1
    fi
}

show_picker() {
    if pgrep -x "switar"; then
        exit 1
    else
        ${HOME}/.local/share/bin/switar
    fi
}

case "$1" in
    "--picker")
        show_picker
        ;;
    "--randomize")
        wallpaper_random
        ;;
    "--check")
        load_wallpaper
        ;;
    *)
        wallpaper_random
        ;;
esac
