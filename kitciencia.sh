#!/bin/bash
# Kit científico completo para Ubuntu

echo "Atualizando lista de pacotes..."
sudo apt update

echo "Instalando programas científicos principais..."
sudo apt install -y scilab gnuplot geogebra octave electric stellarium

echo "Instalando bibliotecas Python para ciência e engenharia..."
sudo apt install -y python3-numpy python3-scipy python3-matplotlib python3-pandas python3-sympy python3-seaborn

echo "Instalando ambiente de estatística e análise de dados..."
sudo apt install -y r-base r-cran-ggplot2

echo "Instalando LaTeX para escrita científica..."
sudo apt install -y texlive-full

echo "Instalando ferramentas extras úteis..."
sudo apt install -y maxima kalzium jupyter-notebook

echo "Instalação concluída ✅"


