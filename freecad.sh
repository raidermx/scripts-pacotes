#!/bin/bash

echo "======================================="
echo "   Instalador do FreeCAD para Ubuntu   "
echo "======================================="
echo ""
echo "Escolha o método de instalação:"
echo "1) PPA (versão estável mais atualizada)"
echo "2) Snap (instalação rápida e automática)"
echo "3) Flatpak (via Flathub)"
echo "4) Sair"
echo ""

read -p "Digite a opção desejada [1-4]: " opcao

case $opcao in
    1)
        echo ">> Instalando FreeCAD via PPA..."
        sudo apt update
        sudo apt install -y software-properties-common apt-transport-https
        sudo add-apt-repository -y ppa:freecad-maintainers/freecad-stable
        sudo apt update
        sudo apt install -y freecad
        echo "✅ FreeCAD instalado via PPA!"
        ;;
    2)
        echo ">> Instalando FreeCAD via Snap..."
        sudo snap install freecad
        echo "✅ FreeCAD instalado via Snap!"
        ;;
    3)
        echo ">> Instalando FreeCAD via Flatpak..."
        sudo apt install -y flatpak
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak install -y flathub org.freecadweb.FreeCAD
        echo "✅ FreeCAD instalado via Flatpak!"
        ;;
    4)
        echo "Saindo..."
        exit 0
        ;;
    *)
        echo "❌ Opção inválida. Execute novamente."
        ;;
esac

