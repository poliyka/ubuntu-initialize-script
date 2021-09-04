import os
from base import (
    echo,
    update_file,
)


def update_git_config():
    # file_name = u".config"
    file_name = u"test.cfg"
    directory_path = os.path.expanduser("~")
    # file_path = f"{directory_path}/{file_name}"
    file_path = f"{directory_path}/ubuntu-initialize-script/{file_name}"

    match_str = "[alias]"

    insert_str = r"""
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
    """
    update_file(file_path, match_str, insert_str)

if __name__ == '__main__':
    update_git_config()
