#!/bin/bash
# preparations
DIRCT=`pwd`

# enable multilib
sudo echo '[multilib]' >> /etc/pacman.conf
sudo echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
sudo pacman -Syu

# installing pkgs that need to comfortable work
sudo pacman -S tar zip unzip fakeroot\
 foot git gcc make automake patch python npm curl wget\
 openssh vim neovim ripgrep\
 sway swaybg i3status wofi dunst\
 nvidia lib32-nvidia-utils mesa lib32-mesa\
 xclip wl-clipboard\
 rsync pulseaudio alsa-utils pavucontrol\
 bluez bluez-utils blueman pulseaudio-bluetooth\
 postgresql-libs sqlite\
 ncdu mc ranger htop\
 brightnessctl playerctl pkg-config\
 ffmpeg mpv mpc feh grim slurp\
 awesome-terminal-fonts\
 openvpn networkmanager network-manager-applet\
 w3m firefox torbrowser-launcher qt5-wayland keepassxc\
 powertop tlp\
 docker docker-compose\
 android-tools libmtp\
 gimp libreoffice-fresh neofetch\
 telegram-desktop\
 pyenv

# todo: to be added aur package 'adbfs-rootless-git'

# basic set up for Neovim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# config prepare stage
cp .bashrc ~/.bashrc
cp .bash_profile ~/.bash_profile
cp .xinitrc ~/.xinitrc
cp .Xresources ~/.Xresources
cp .gitconfig ~/.gitconfig
cp .liquidpromptrc ~/.liquidpromptrc
cp .bg.jpg ~/.bg.jpg
cd config && cp -r * ~/.config/ && cd ..

# adding user to groups 
sudo usermod -a -G audio ${USER}
sudo usermod -a -G video ${USER}
sudo usermod -a -G docker ${USER}

# installing audio firmware, please skip this step
wget https://github.com/thesofproject/sof-bin/releases/download/v2023.12/sof-bin-2023.12.tar.gz
tar -xvf sof-bin*
cd sof-bin*
chmod +x install.sh && sudo bash install.sh
cd .. && rm -rf sof-bin

# installing liquidprompt
git clone --branch stable https://github.com/nojhan/liquidprompt.git ~/.liquidprompt
# next step actually was added to bashrc
# echo '[[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt' >> ~/.bashrc

# clone anywhere you like, but adjust paths as needed
mkdir ~/.config/dracula-theme && cd ~/.config/dracula-theme
git clone https://github.com/dracula/midnight-commander.git

mkdir -p ~/.local/share/mc/skins && cd ~/.local/share/mc/skins
ln -s ~/.config/dracula-theme/midnight-commander/skins/dracula.ini
ln -s ~/.config/dracula-theme/midnight-commander/skins/dracula256.ini
cd $DIRCT

# installing fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip 
sudo mkdir -p /usr/share/fonts
sudo mkdir -p /usr/share/fonts/JetBrainsMono
mkdir JetBrainsMono && mv JetBrainsMono.zip JetBrainsMono/ && cd JetBrainsMono
unzip JetBrainsMono.zip && sudo cp *.ttf /usr/share/fonts/JetBrainsMono
cd .. && rm -rf JetBrainsMono
fc-cache

# installing gpu switch control app
git clone https://github.com/bayasdev/envycontrol.git ~/.envycontrol

# translate in shell
git clone https://github.com/soimort/translate-shell && cd translate-shell
make && sudo make install
cd .. && rm -rf translate-shell

# slack
wget https://aur.archlinux.org/packages/slack-desktop-wayland.tar.gz
tar -xvf slack-desktop-wayland.tar.gz && cd slack-desktop-wayland
makepkg -si
cd .. && rm -rf slack-desktop*

# openvpn3
cd $DIRCT
wget https://aur.archlinux.org/cgit/aur.git/snapshot/openvpn3.tar.gz
tar -xvf openvpn3*
cd openvpn3
makepkg -si
cd ..
rm -rf openvpn3*

# restart services
systemctl restart bluetooth

echo 'DONE!'
