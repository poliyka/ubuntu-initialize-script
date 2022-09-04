#!/bin/bash
################################################################################
# Script for installing Ubuntu 20.04 initialize dependencise package
# Author: Poliyka
################################################################################

#--------------------------------------------------
# OE Settings
# OE SYS:
# 1 : Debian, Ubuntu, Mint
# 2 : Red Hat, Fedora, CentOS
# 3 : SUSE
# 4 : MacOS
# 5 : Zsh
#--------------------------------------------------
OE_USER="poliyka"
OE_HOME="/home/$OE_USER"
OE_SYS="1"

#--------------------------------------------------
# Choose Dependencise
#--------------------------------------------------
UPDATE_SERVER="True"
INSTALL_DEPENDEN="True"

# Choices Packages
INSTALL_RANGER="True"
INSTALL_NVM="True"
INSTALL_YARN="True"
INSTALL_FZF="True"
INSTALL_PYENV="True"
CONFIG_BASHRC_COLOR="True"
CONFIG_GIT_ALIAS="True"

#--------------------------------------------------
# Update Server
#--------------------------------------------------
if [ $UPDATE_SERVER = "True" ]; then
  echo -e "\n---- Update Server ----"
  sudo apt-get update
  sudo apt-get upgrade -y
fi

#--------------------------------------------------
# Install Dependencies
#--------------------------------------------------
if [ $INSTALL_DEPENDEN = "True" ]; then
  echo -e "\n---- Installing apt-get Dependencise ----"
  sudo apt-get install python3-venv python3-wheel libxslt-dev libzip-dev libldap2-dev libsasl2-dev -y
  sudo apt-get install python3-setuptools node-less libjpeg-dev gdebi python3-virtualenv -y
  sudo apt-get install git python3 python3-pip build-essential wget make vim python3-dev -y
  sudo apt-get install libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl llvm libncurses5-dev -y
  sudo apt-get install libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl libxml2-dev -y
  sudo apt-get install libxslt1-dev libjpeg62-dev vim-gtk3 pipenv silversearcher-ag exuberant-ctags figlet tox net-tools htop -y
fi

#--------------------------------------------------
# Install Ranger
#--------------------------------------------------
if [ $INSTALL_RANGER = "True" ]; then
  echo -e "\n---- Install Ranger ----"
  sudo git clone https://github.com/ranger/ranger.git $OE_HOME/ranger
  sudo su - -c "cd ${OE_HOME}/ranger; make install"
  sudo su $OE_USER -c "ranger --copy-config=all"
  sudo rm -rf ${OE_HOME}/ranger

  echo -e "\n---- Set Ranger open on vscode command ----"
  sed -i -e '$a\
\nclass code(Command):\
    def execute(self):\
        dirname = self.fm.thisdir.path\
        codecmd = ["code", dirname]\
        self.fm.execute_command(codecmd)\
' $OE_HOME/.config/ranger/commands.py
fi

#--------------------------------------------------
# Install Nvm + Yarn
#--------------------------------------------------
if [ $INSTALL_NVM = "True" ]; then
  echo -e "\n---- Install Nvm Mnager ----"
  sudo su $OE_USER -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash"
fi

if [ $INSTALL_YARN = "True" ]; then
  echo -e "\n---- Install Yarn ----"
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install yarn -y
fi

#--------------------------------------------------
# Install fzf
#--------------------------------------------------
if [ $INSTALL_FZF = "True" ]; then
  echo -e "\n---- Install fzf ----"
  sudo su $OE_USER -c "git clone --depth 1 https://github.com/junegunn/fzf.git $OE_HOME/.fzf"
  sudo su $OE_USER -c ${OE_HOME}/.fzf/install << 'EOF'
y
y
y
EOF
fi

#--------------------------------------------------
# Install pyenv
#--------------------------------------------------
if [ $INSTALL_PYENV = "True" ]; then
  echo -e "\n---- Install pyenv ----"
  sudo su $OE_USER -c "curl -L https://raw.github.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash"

  # (Debian, Ubuntu, Mint):
  if [ $OE_SYS = "1" ]; then
    sed -Ei -e '/^([^#]|$)/ {a \
export PYENV_ROOT="$HOME/.pyenv"
a \
export PATH="$PYENV_ROOT/bin:$PATH"
a \
    ' -e ':a' -e '$!{n;ba};}' $OE_HOME/.profile
    echo 'eval "$(pyenv init --path)"' >>$OE_HOME/.profile
    echo 'eval "$(pyenv init -)"' >> $OE_HOME/.bashrc
  fi

  # (Red Hat, Fedora, CentOS):
  if [ $OE_SYS = "2" ]; then
    sed -Ei -e '/^([^#]|$)/ {a \
export PYENV_ROOT="$HOME/.pyenv"
a \
export PATH="$PYENV_ROOT/bin:$PATH"
a \
' -e ':a' -e '$!{n;ba};}' $OE_HOME/.bash_profile
    echo 'eval "$(pyenv init --path)"' >> $OE_HOME/.bash_profile
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $OE_HOME/.profile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $OE_HOME/.profile
    echo 'eval "$(pyenv init --path)"' >> $OE_HOME/.profile
    echo 'eval "$(pyenv init -)"' >> $OE_HOME/.bashrc
  fi

  # (SUSE):
  if [ $OE_SYS = "3" ]; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $OE_HOME/.profile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $OE_HOME/.profile
    echo 'eval "$(pyenv init --path)"' >> $OE_HOME/.profile
    echo 'if command -v pyenv >/dev/null; then eval "$(pyenv init -)"; fi' >> $OE_HOME/.bashrc
  fi

  # (MacOS):
  if [ $OE_SYS = "4" ]; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $OE_HOME/.profile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $OE_HOME/.profile
    echo 'eval "$(pyenv init --path)"' >> $OE_HOME/.profile
    echo 'if [ -n "$PS1" -a -n "$BASH_VERSION" ]; then source ~/.bashrc; fi' >> $OE_HOME/.profile
    echo 'eval "$(pyenv init -)"' >> $OE_HOME/.bashrc
  fi

  # (Zsh):
  if [ $OE_SYS = "5" ]; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
  fi

fi

#--------------------------------------------------
# Config bashrc
#--------------------------------------------------
if [ $CONFIG_BASHRC_COLOR = "True" ]; then
  echo -e "\n---- Config bashrc color ----"
  sed -i -e '$a\
\
parse_git_branch() {\
  git branch 2> /dev/null | sed -e \"/^[^*]/d\" -e \"s/* \\(.*\\)/ (\\1)/\"\
}\
export PS1=\"\\[\\033[01;32m\\]\\u@\\h\\[\\e[91m\\]\\$(parse_git_branch) \\[\\e[1;33m\\]\\D{%Y/%m/%d} \\t\\[\\033[00m\\]:\\n\\[\\e[34m\\]\\w\\[\\e[00m\\]\$ \"
' $OE_HOME/.bashrc
fi

#--------------------------------------------------
# Config Git Alias
#--------------------------------------------------
if [ $CONFIG_GIT_ALIAS = "True" ]; then
  echo -e "\n---- Config git alias ----"
  GITCONFIG_PATH=$OE_HOME/.gitconfig
  if [[ ! -f "$GITCONFIG_PATH" ]]; then
    sudo su $OE_USER -c "touch ${GITCONFIG_PATH}"
  fi

  if ! sed -n '/\[alias\]/p' $GITCONFIG_PATH | grep '[alias]'; then
    sudo su $OE_USER -c "printf '[alias]\n' >> $GITCONFIG_PATH"
  fi
  sudo su $OE_USER -c "python3 git_config.py"
fi


echo "-----------------------------------------------------------"
echo "Done! Ubuntu Initialize Dependenies:"
echo "  INSTALL_RANGER = ${INSTALL_RANGER}"
echo "  INSTALL_NVM = ${INSTALL_NVM}"
echo "  INSTALL_YARN = ${INSTALL_YARN}"
echo "  INSTALL_FZF = ${INSTALL_FZF}"
echo "  INSTALL_PYENV = ${INSTALL_PYENV}"
echo "  CONFIG_BASHRC_COLOR = ${CONFIG_BASHRC_COLOR}"
echo "  CONFIG_GIT_ALIAS = ${CONFIG_GIT_ALIAS}"
echo "Finished. Restart your shell or reload config file."
echo "source ~/.bashrc"
echo "-----------------------------------------------------------"
