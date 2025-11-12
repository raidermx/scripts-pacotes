#!/bin/bash
# Script de instalação do QGIS no Ubuntu
# Fonte: https://qgis.org/resources/installation-guide/#debian--ubuntu

set -e

echo "🔑 Instalando dependências necessárias..."
sudo apt update
sudo apt install -y gnupg software-properties-common wget lsb-release

echo "🔑 Adicionando chave de assinatura do QGIS..."
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg

# Detecta automaticamente o codename da distribuição (ex: jammy, noble, etc.)
DISTRO=$(lsb_release -cs)

echo "📦 Configurando repositório do QGIS para Ubuntu $DISTRO..."
cat <<EOF | sudo tee /etc/apt/sources.list.d/qgis.sources
Types: deb deb-src
URIs: https://qgis.org/ubuntu
Suites: $DISTRO
Architectures: amd64
Components: main
Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg
EOF

echo "🔄 Atualizando lista de pacotes..."
sudo apt update

echo "📥 Instalando QGIS (desktop + plugin GRASS)..."
sudo apt install -y qgis qgis-plugin-grass

# Caso queira instalar também o servidor QGIS, descomente a linha abaixo:
# sudo apt install -y qgis-server --no-install-recommends --no-install-suggests

echo "✅ Instalação concluída! Para iniciar, digite: qgis"

