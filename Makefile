all:
	configure

helper:
	@echo "Installing paru for your AUR helper, please wait..."
	sudo pacman -S --needed --noconfirm git base-devel
	git clone https://aur.archlinux.org/paru.git
	cd paru && makepkg -si
	cd ../ && rm -rf paru

packages: helper
	@echo "Installing some packages with AUR helper, may take long so take your time..."
	@./scripts/packages.sh

dirs:
	@echo "Creating some essential directories, be patient..."
	mkdir ${HOME}/Pictures
	mkdir ${HOME}/Pictures/Wallpapers
	mkdir ${HOME}/Pictures/Screenshots

services: packages
	@./scripts/services.sh

configure: dirs services
	@./scripts/installation.sh
	@echo "Congrats, you may set your desktop theme now"
	@nwg-look
