#!/bin/bash
# installing pkgs that need to comfortable work
sudo apt install git i3 brightnessctl playerctl feh flameshot fonts-font-awesome x11vnc emacs ncdu mc htop
# adding user to video group to grant access for brightness control
sudo usermod -a -G video ${USER}
# clone spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
