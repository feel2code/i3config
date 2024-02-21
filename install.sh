#!/bin/bash
# installing pkgs that need to comfortable work
pacman -S terminator git vim neovim i3 brightnessctl playerctl feh flameshot fonts-font-awesome ncdu mc ranger htop liquidpromt keepassxc firefox
# adding user to video group to grant access for brightness control
sudo usermod -a -G video ${USER}
sudo pacman -R dmenu
git clone https://git.suckless.org/dmenu
cp dmenu-center-format.patch dmenu/dmenu-center-format.patch
cd dmenu
path -i dmenu-center-format.patch
make && sudo make install
cd ..
rm -rf dmenu
