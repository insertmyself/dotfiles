#!/bin/sh
set -euo pipefail

echo "Enabling some needed services, be patient..."
systemctl enable --user mpd.service
systemctl enable --user mpd-mpris.service
systemctl enable --user pipewire.service
systemctl enable --user pipewire-pulse.service
systemctl enable --user wireplumber.service
sudo systemctl enable cups.service
sudo systemctl enable ufw.service
sudo ufw allow 53317/tcp
sudo ufw allow 53317/udp
sudo ufw allow 3000/tcp
sudo ufw allow 3000/udp
sudo ufw allow 80/tcp
sudo ufw allow 80/udp
sudo ufw allow 443/tcp
sudo ufw allow 443/udp
ufw enable
