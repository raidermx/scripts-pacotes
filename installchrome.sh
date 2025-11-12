#!/bin/bash
# instalar o google chrome
cd /tmp && wget -O google-chrome-stable.deb 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo apt install ./google-chrome-stable.deb && cd $HOME

