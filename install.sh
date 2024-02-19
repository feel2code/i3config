#!/bin/bash
# installing pkgs that need to comfortable work
pacman -S terminator git vim neovim i3 brightnessctl playerctl feh flameshot fonts-font-awesome ncdu mc ranger htop bat liquidpromt keepassxc firefox
# adding user to video group to grant access for brightness control
sudo usermod -a -G video ${USER}
