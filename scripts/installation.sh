#!/bin/sh
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"

link() {
  SOURCE="${DOTFILES}/$1"
  DESTINATION="${HOME}/$2"

  if [[ -L "${DESTINATION}" ]]; then
    echo "${DESTINATION} already linked, going to the next file"
    return
  fi

  if [[ -e "${DESTINATION}" ]]; then
    mv "${DESTINATION}" "${DESTINATION}.bak.$(date +%s)"
    echo "Created backup for ${DESTINATION}"
  fi

  mkdir -p "$(dirname "${DESTINATION}")"
  ln -s "${SOURCE}" "${DESTINATION}"
  echo "Successfully linked ${SOURCE} to ${DESTINATION}"
}

echo "Installing oh-my-zsh for the shell theming, please wait..."
sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Overriding the zsh theme, please wait..."
link zsh/themes/alanpeabody.zsh-theme .config/zsh/oh-my-zsh/themes
echo "Configuring the config into your system, will open neovim when this done so wait until it finishes downloading..."
link Pictures Pictures
link zsh/.zshrc .config/zsh
link nvim .config
link kitty .config
link fastfetch .config
link quickshell .config
link git .config
link typy .config
link mpd .config
link rmpc .config
link ncmpcpp .config
link rofi .config
link mpv .config
link posting .config
link .local/share/bin .local/share
link .local/share/fonts .local/share
link .local/share/icons .local/share
link .local/share/themes .local/share
nvim
echo "Overriding some neovim plugins configurations, please wait..."
link .local/share/nvim/lazy .local/share/nvim	
