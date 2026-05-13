#!/bin/sh
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKGLIST="${DOTFILES}/packages/list.txt"

spinner() {
  local PID=$1
  local MESSAGE=$2
  local CHAR="|/-\\"
  local INDEX=0

  echo -n "${MESSAGE}"

  while kill -0 "${PID}" 2>/dev/null; do
    printf "\b%c" "${CHAR:i++%${#CHAR}:1}"
    sleep 0.1
  done
}

install_package() {
  local PACKAGE="$1"

  if pacman -Qi "${PACKAGE}" &>/dev/null; then
    echo "Package ${PACKAGE} already installed"
    return
  fi

  paru -S --needed --noconfirm "${PACKAGE}" >/tmp/paru-"${PACKAGE}".log 2>&1 &
  PID=$!

  spinner "${PID}" "Installing package ${PACKAGE}, please wait..."

  if ! wait "${PID}"; then
    echo "Failed to install package ${PACKAGE}"
    echo "Logs can be found at /tmp/paru-${PACKAGE}.log"
    exit 1
  fi

  echo "Successfully installed package ${PACKAGE}"
}

while read -r PACKAGE; do
  [[ -z "${PACKAGE}" || "${PACKAGE}" == \#* ]] && continue
  install_package "${PACKAGE}"
done < "${PKGLIST}"
