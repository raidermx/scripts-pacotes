#!/bin/bash
# Script de instalação de pacotes e configurações no Ubuntu

# Atualização inicial
sudo apt update && sudo apt upgrade -y

# Pacotes básicos
sudo apt install -y apturl apturl-common build-essential dkms

# GNOME
sudo apt install -y gnome-software gnome-tweaks
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# Firewall
sudo apt install -y ufw gufw
sudo ufw enable

# Ajustes de memória (sysctl.conf)
sudo bash -c 'cat <<EOF >> /etc/sysctl.conf
vm.swappiness=10
vm.vfs_cache_pressure=50
vm.dirty_background_bytes=16777216
vm.dirty_bytes=50331648
EOF'

# TLP (economia de energia)
sudo apt install -y tlp tlp-rdw
sudo systemctl enable tlp.service && sudo tlp start

# Flatpak
sudo apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Pacotes multimídia e utilitários
sudo apt install -y ubuntu-restricted-extras audacious libqt6svg6 vlc smplayer kodi audacity blender gimp handbrake inkscape kdenlive krita krita-l10n obs-studio openshot-qt rawtherapee digikam darktable shotcut mpv

# Codecs e fontes
sudo apt install -y faad ffmpeg gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly lame libavcodec-extra libavcodec-extra59 libavdevice59 libgstreamer1.0-0 sox twolame vorbis-tools ttf-mscorefonts-installer fonts-hack-ttf ImageMagick materia-gtk-theme deepin-icon-theme paper-icon-theme libreoffice-l10n-pt-br libreoffice-style-breeze libreoffice-style-colibre libreoffice-style-elementary libreoffice-style-hicontrast libreoffice-style-sifr

# CAD
sudo apt install -y librecad leocad
sudo add-apt-repository -y ppa:freecad-maintainers/freecad-stable
sudo apt update && sudo apt install -y freecad freecad-doc

# Discord
cd /tmp && wget -O discord.deb 'https://discord.com/api/download?platform=linux&format=deb'
sudo apt install -y ./discord.deb && cd $HOME

# Telegram
sudo snap install telegram-desktop

# Google Chrome
cd /tmp && wget -O google-chrome-stable.deb 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo apt install -y ./google-chrome-stable.deb && cd $HOME

# Microsoft Edge
echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge/ stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
sudo apt install -y curl
cd /tmp && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && cd $HOME
sudo apt update && sudo apt install -y microsoft-edge-stable

# Jogos
sudo apt install -y steam lutris
flatpak install -y flathub org.DolphinEmu.dolphin-emu io.github.lime3ds.Lime3DS org.flycast.Flycast net.pcsx2.PCSX2 net.rpcs3.RPCS3 com.snes9x.Snes9x io.mgba.mGBA app.xemu.xemu org.ryujinx.Ryujinx

# Compactadores e utilitários
sudo apt install -y arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip gdebi stacer uget qbittorrent gparted synaptic
flatpak install -y flathub io.github.flattool.Warehouse

# AnyDesk
cd /tmp && wget -qO- https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/anydesk.gpg && cd $HOME
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update && sudo apt install -y anydesk

echo "Instalação concluída!"

