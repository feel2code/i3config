#!/bin/bash
# installing pkgs that need to comfortable work
pacman -S git vim terminator i3 brightnessctl playerctl feh flameshot fonts-font-awesome emacs ncdu mc ranger htop bat liquidpromt keepassxc
# adding user to video group to grant access for brightness control
sudo usermod -a -G video ${USER}
