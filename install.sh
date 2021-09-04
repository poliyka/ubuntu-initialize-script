#!/bin/bash
################################################################################
# Script for installing Ubuntu 20.04 initialize dependencise package
# Author: Poliyka
#-------------------------------------------------------------------------------
# This script install List
#
#-------------------------------------------------------------------------------
# Make a new file:
################################################################################

#--------------------------------------------------
# OE Settings
#--------------------------------------------------
OE_USER="poliyka"
OE_HOME="/home/$OE_USER"

#--------------------------------------------------
# Choose Dependencise
#--------------------------------------------------
INSTALL_RANGER="True"
INSTALL_NVM="True"
INSTALL_YARN="True"

#--------------------------------------------------
# Update Server
#--------------------------------------------------
# echo -e "\n---- Update Server ----"
# sudo apt-get update
# sudo apt-get upgrade -y

#--------------------------------------------------
# Install Dependencies
#--------------------------------------------------
# echo -e "\n---- Installing apt-get Dependencise ----"
# sudo apt-get install git python3 python3-pip build-essential wget make vim python3-dev -y
# sudo apt-get install python3-venv python3-wheel libxslt-dev libzip-dev libldap2-dev libsasl2-dev -y
# sudo apt-get install python3-setuptools node-less libpng12-0 libjpeg-dev gdebi python3-virtualenv -y
# sudo apt-get install libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl llvm libncurses5-dev -y
# sudo apt-get install libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl  libxml2-dev -y
# sudo apt-get install libxslt1-dev libjpeg62-dev vim-gtk3 pipenv silversearcher-ag exuberant-ctags figlet tox net-tools -y

#--------------------------------------------------
# Install Ranger
#--------------------------------------------------
# if [ $INSTALL_RANGER = "True" ]; then
#   echo -e "\n---- Install Ranger ----"
#   sudo git clone https://github.com/ranger/ranger.git $OE_HOME/ranger
#   sudo su - -c "cd ${OE_HOME}/ranger; make install"
#   sudo su $OE_USER -c "ranger --copy-config=all"
#   sudo rm -rf ${OE_HOME}/ranger

#   echo -e "\n---- Set Ranger open on vscode command ----"
#   sed -i -e '$a\
#   class code(Command):\
#   \tdef execute(self):\
#   \t\tdirname = self.fm.thisdir.path\
#   \t\tcodecmd = ["code", dirname]\
#   \t\tself.fm.execute_command(codecmd)\
#   ' $OE_HOME/.config/ranger/commands.py
# fi

#--------------------------------------------------
# Install Nvm + Yarn
#--------------------------------------------------
# if [ $INSTALL_NVM = "True" ]; then
#   echo -e "\n---- Install Nvm Mnager ----"
#   sudo su $OE_USER -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash"
# fi

#if [ $INSTALL_YARN = "True" ]; then
#  echo -e "\n---- Install Yarn ----"
#  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
#  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
#  sudo apt-get update && sudo apt-get install yarn -y
#fi

echo "-----------------------------------------------------------"
echo "Done! Ubuntu Initialize Dependenies:"
echo "Nginx configuration file: /etc/nginx/sites-available/odoo"
echo "-----------------------------------------------------------"
