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
INSTALL_FZF="True"
CONFIG_BASHRC="True"
CONFIG_GIT_ALIAS="True"

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
# class code(Command):\
# \tdef execute(self):\
# \t\tdirname = self.fm.thisdir.path\
# \t\tcodecmd = ["code", dirname]\
# \t\tself.fm.execute_command(codecmd)\
# ' $OE_HOME/.config/ranger/commands.py
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

#--------------------------------------------------
# Install fzf
#--------------------------------------------------
# if [ $INSTALL_FZF = "True" ]; then
#  echo -e "\n---- Install fzf ----"
#  sudo su $OE_USER -c "git clone --depth 1 https://github.com/junegunn/fzf.git $OE_HOME/.fzf"
#  sudo su $OE_USER -c "cd ${OE_HOME}/.fzf;./install"
# fi


#--------------------------------------------------
# Config bashrc
#--------------------------------------------------
# if [ $CONFIG_BASHRC = "True" ]; then
#   sed -i -e '$a\
# parse_git_branch() {\
#   git branch 2> /dev/null | sed -e \"/^[^*]/d\" -e \"s/* \\(.*\\)/(\\1)/\"\
# }\
# export PS1=\"\\[\\033[01;32m\\]\\u@\\h \\[\\e[91m\\]\\$(parse_git_branch) \\[\\e[1;33m\\]\\D{%Y/%m/%d} \\t\\[\\033[00m\\]:\\n\\[\\e[34m\\]\\w\\[\\e[00m\\]\$ \"
# ' $OE_HOME/.bashrc
# fi


#--------------------------------------------------
# Config Git Alias
#--------------------------------------------------
if [ $CONFIG_GIT_ALIAS = "True" ]; then
  if [ -f "${$OE_HOME}/.gitconfig" ]; then
    echo '.gitconfig already exist!'
  else
    cat <<EOF > $OE_HOME/.gitconfig
[alias]
  st = status
  cm = commit
  ch = checkout
  br = branch
  mg = merge
  acm =  "!git add -A && git commit -m"
  mgd = "!git mg $1 && git br -d $1; #"
  # 查看分支(樹狀圖)
  lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
  # 查看reflog(HeighLight)
  rl = reflog --pretty=format:\"%Cred%h%Creset %C(auto)%gd%Creset %C(auto)%gs%C(reset) %C(green)(%cr)%C(reset) %C(bold blue)<%an>%Creset\" --abbrev-commit
  # 查看stash(HeighLight)
  sl = stash list --pretty=format:\"%C(red)%h%C(reset) - %C(dim yellow)(%C(bold magenta)%gd%C(dim yellow))%C(reset) %<(70,trunc)%s %C(green)(%cr) %C(bold blue)<%an>%C(reset)\"
EOF
fi
fi

echo "-----------------------------------------------------------"
echo "Done! Ubuntu Initialize Dependenies:"
echo "Finished. Restart your shell or reload config file."
echo "source ~/.bashrc"
echo "-----------------------------------------------------------"
