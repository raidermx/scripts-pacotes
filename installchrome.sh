#!/bin/bash
# Script para instalar o Google Chrome no Ubuntu

set -e  # faz o script parar se ocorrer algum erro

# Baixar o pacote .deb
cd /tmp
wget -q -O google-chrome-stable.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

# Instalar dependências e o Chrome
sudo apt update
sudo apt install -y ./google-chrome-stable.deb

# Limpar arquivo baixado
rm google-chrome-stable.deb

# Voltar para o diretório home
cd "$HOME"

echo "✅ Google Chrome instalado com sucesso!"
