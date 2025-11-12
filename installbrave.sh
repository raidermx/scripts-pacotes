#!/bin/bash
# Script de instalação do navegador Brave

# Atualiza lista de pacotes e instala curl
sudo apt update
sudo apt install -y curl

# Adiciona a chave GPG do Brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

# Adiciona o repositório do Brave
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources \
  https://brave-browser-apt-release.s3.brave.com/brave-browser.sources

# Atualiza novamente e instala o Brave
sudo apt update
sudo apt install -y brave-browser

echo "✅ Instalação concluída! Você pode abrir o Brave digitando 'brave-browser' no terminal."

