#!/bin/sh
OPTIONS=("Extra" "Core" "Aur" "Multilib")

search_aur() {
    SEARCH=$(rofi -dmenu -i -p " ${CHOOSE}" -theme-str "configuration { show-icons: false; } window { width: 30%; } listview { lines: 5; }" -no-fixed-num-lines)
    if [[ -z "${SEARCH}" ]]; then
        $HOME/.config/hypr/scripts/menus/main.sh
        exit 0
    fi
    CHOOSE=${CHOOSE,,}
    PACKAGE=$(paru -aSs "${SEARCH}" | grep "${SEARCH}" | sed -n 's/^\([^ ]*\/\)\([^ ]*\).*$/\1\2/p' | awk -F'/' '{print "["$1"] "$2}' | sort -u)
}

search_repos() {
    SEARCH=$(rofi -dmenu -i -p " ${CHOOSE}" -theme-str "configuration { show-icons: false; } window { width: 30%; } listview { lines: 5; }" -no-fixed-num-lines)
    if [[ -z "${SEARCH}" ]]; then
        $HOME/.config/hypr/scripts/menus/main.sh
        exit 0
    fi
    CHOOSE=${CHOOSE,,}
    PACKAGE=$(paru -Ss "${SEARCH}" | grep "${CHOOSE}/" | grep "${SEARCH}" | sed -n 's/^\([^ ]*\/\)\([^ ]*\).*$/\1\2/p' | awk -F'/' '{print "["$1"] "$2}' | sort -u)
}

CHOOSE=$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -i -p " Select" -theme-str "configuration { show-icons: false; } window { width: 20%; } listview { lines: 4; }" -no-fixed-num-lines)

if [[ -z "${CHOOSE}" ]]; then
    $HOME/.config/hypr/scripts/menus/main.sh
    exit 0
fi

case "${CHOOSE}" in
    Aur)
        search_aur
        ;;
    Multilib|Core|Extra)
        search_repos
        ;;
    *)
        rofi -e "Selected repo doesn't exist" -theme-str "window { width: 22%; }"
        $HOME/.config/hypr/scripts/menus/installer.sh
        exit 0
        ;;
esac

if [[ -z "${PACKAGE}" ]]; then
    rofi -e "Package doesn't exist" -theme-str "window { width: 18%; }"
    $HOME/.config/hypr/scripts/menus/main.sh
    exit 0
fi

SELECTED=$(echo "${PACKAGE}" | rofi -dmenu -i -p "󰏓 Install" -theme-str "configuration { show-icons: false; } window { width: 35%; } listview { lines: 13; }" -no-fixed-num-lines)

if [[ "$?" -eq 0 ]] && [[ -n "${SELECTED}" ]]; then
    PACKAGE_NAME=$(echo "${SELECTED}" | sed 's/^\[\(.*\)\] \(.*\)/\1\/\2/' | awk -F '/' '{print $NF}')
    if pacman -Qq "${PACKAGE_NAME}" &>/dev/null; then
        rofi -e "Package has already installed" -theme-str "window { width: 23%; }"
        $HOME/.config/hypr/scripts/menus/main.sh
        exit 0
    fi
    kitty --title "Installer" sh -c "paru -S ${PACKAGE_NAME}"
    if pacman -Qq "${PACKAGE_NAME}" &>/dev/null; then
        rofi -e "Package installed successfully" -theme-str "window { width: 24%; }"
        exit 0
    else
        rofi -e "Package installation aborted" -theme-str "window { width: 23%; }"
        exit 0
    fi
else
    rofi -e "Package installation aborted" -theme-str "window { width: 23%; }"
    $HOME/.config/hypr/scripts/menus/main.sh
    exit 0
fi
