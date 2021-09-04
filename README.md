# Ubuntu 20.04 初始化腳本

## Configuration

- [install.sh](./install.sh) 中修正使用者名稱

```python
...
#--------------------------------------------------
# OE Settings
#--------------------------------------------------
OE_USER="poliyka"
...
```

- [install.sh](./install.sh) 選擇需要的套件

```python
...
#--------------------------------------------------
# Choose Dependencise
#--------------------------------------------------
INSTALL_RANGER="True"
INSTALL_NVM="True"
INSTALL_YARN="True"
INSTALL_FZF="True"
CONFIG_BASHRC_COLOR="True"
CONFIG_GIT_ALIAS="True"
...
```

## Usage

```h
sudo ./install.sh
```

## Notice

- 不要重複安裝相同的套件，否則會產生 Garbage Code.
