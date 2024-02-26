#!/bin/bash
# installing pkgs that need to comfortable work
sudo pacman -S \
  xterm git gcc make automake python curl wget vim neovim ripgrep i3 dunst \
  postgresql-libs sqlite \
  fonts-font-awesome ncdu mc ranger htop \
  brightnessctl playerctl \
  ffmpeg mpv mpc feh flameshot \
  w3m firefox torbrowser-launcher keepassxc \
  arandr powertop tlp \
  docker docker-compose \
  gimp libreoffice-fresh neofetch

# basic set up for Neovim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# config prepare stage
cat .bashrc > ~/.bashrc
cat .xinitrc > ~/.xinitrc
cat .Xresources > ~/.Xresources
cp .gitconfig ~/.gitconfig
cp .liquidpromptrc ~/.liquidpromptrc
cp .bg.jpg ~/.bg.jpg
cd config && cp -r * ~/.config/ && cd ..

# adding user to video group to grant access for brightness control
sudo usermod -a -G video ${USER}

# openvpn3
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/openvpn3.tar.gz
tar -xvf openvpn3.tar.gz && cd openvpn3 && makepkg -si && cd ..
rm -rf openvpn3*

# installing liquidprompt
git clone --branch stable https://github.com/nojhan/liquidprompt.git ~/.liquidprompt
# next step actually was added to bashrc
# echo '[[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt' >> ~/.bashrc

# installing dmenu and patch it for center
sudo pacman -R dmenu
git clone https://git.suckless.org/dmenu
cp dmenu-center-format.patch dmenu/dmenu-center-format.patch
cd dmenu
patch -i dmenu-center-format.patch && make && sudo make install
cd .. && rm -rf dmenu

# installing fonts
curl -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip 
unzip JetBrainsMono.zip && cp -r JetBrainsMono /usr/local/share/fonts/ && rm -rf JetBrainsMono
fc-cache

# installing gpu switch control app
git clone https://github.com/bayasdev/envycontrol.git ~/.envycontrol

# translate in shell
git clone https://github.com/soimort/translate-shell && cd translate-shell
make && sudo make install
cd .. && rm -rf translate-shell
